#!/bin/bash

BASEDIR=$(dirname $0)
. $BASEDIR/_functions.sh

GIT_USERNAME=
RELEASE=
TAG=
NEXT_DEVELOPMENT_VERSION=

function usage {
  cat << EOF

	${PRG} [-h] --git_username <EGerritUser> --release <RELEASE> --development <NEXT_DEVELOPMENT> --tag <TAG>

	-h                                    - Usage info
	-u | --git_username <EGerritUser>     - Eclipse Gerrit Username of Commiter, SSH Key is used for authorisation
	-r | --release <RELEASE>              - <RELEASE> name
	-d | --development <NEXT_DEVELOPMENT> - <NEXT_DEVELOPMENT> name
	-t | --tag <TAG>                      - <TAG> name (Optional / Default: Project Version)

	Example: ${PRG} -u sleicht -r 1.7 -d 1.7.1-SNAPSHOT -t v1.7

EOF
}

function get_options {
	# Loop until all parameters are used up
	while [ "$1" != "" ]; do
		case $1 in
			-u | --git_username )	shift
										GIT_USERNAME=$1
										;;
			-r | --release )			shift
										RELEASE=$1
										;;
			-d | --development )	shift
										NEXT_DEVELOPMENT=$1
										;;
			-t | --tag )					shift
										TAG=$1
										;;
			-h | --help )				usage
										exit 7
										;;
			* )							break;;
		esac
		shift
	done
	_MAVEN_OPTS="$_MAVEN_OPTS $@"
}
get_options $*

if [[ -z  "$GIT_USERNAME" ]]; then
	echo "[ERROR]:       <EGerritUser> missing"
	usage
	exit 7
fi

if [[ -z  "$RELEASE" ]]; then
	echo "[ERROR]:       <RELEASE> missing"
	usage
	exit 7
fi

if [[ -z  "$NEXT_DEVELOPMENT" ]]; then
	echo "[ERROR]:       <NEXT_DEVELOPMENT> missing"
	usage
	exit 7
fi

if [[ "$TAG" ]]; then
	_MAVEN_OPTS="$_MAVEN_OPTS -Dmaster_release_tagName=$TAG"
fi
_MAVEN_OPTS="$_MAVEN_OPTS -e -B"

mvn -Prelease.setversion -Dmaster_release_newVersion=$RELEASE -f maven_plugin_version-master -N $_MAVEN_OPTS
processError

mvn -Prelease.checkin -Declipse_gerrit_username=$GIT_USERNAME -f maven_plugin_version-master $_MAVEN_OPTS
processError

mvn -Prelease.tag -Declipse_gerrit_username=$GIT_USERNAME -Dmaster_release_pushChanges=false -f maven_plugin_version-master $_MAVEN_OPTS
processError

mvn -Prelease.setversion -Dmaster_release_newVersion=$NEXT_DEVELOPMENT -f maven_plugin_version-master -N $_MAVEN_OPTS -Dmaster_release_tagName="master"
processError

mvn -Prelease.checkin -Declipse_gerrit_username=$GIT_USERNAME -Dmaster_release_pushChanges=false -Dmaster_release_checkinMessage="[release] prepare for next development iteration" -f maven_plugin_version-master $_MAVEN_OPTS
processError
