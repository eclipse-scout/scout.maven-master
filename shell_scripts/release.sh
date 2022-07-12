#!/bin/bash

BASEDIR=$(dirname $0)
. $BASEDIR/_functions.sh

GIT_USERNAME=
VERSION=
NEXT_VERSION=

function usage {
  cat << EOF

	${PRG} [-h] --git_username <GitUser> --release <RELEASE> --development <NEXT_DEVELOPMENT> --tag <TAG>

	-h                                    - Usage info
	-u | --git_username <GitUser>         - Eclipse Git Username, SSH Key is used for authorisation
	-r | --release <VERSION>              - <VERSION> name
	-d | --development <NEXT_VERSION>     - <NEXT_VERSION> name
	-t | --tag <TAG>                      - <TAG> name (Optional / Default: <VERSION>)

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
										VERSION=$1
										;;
			-d | --development )	shift
										NEXT_VERSION=$1
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

if [[ -z "$GIT_USERNAME" ]]; then
	echo "[ERROR]:       <GitUser> missing"
	usage
	exit 7
fi

if [[ -z "$VERSION" ]]; then
	echo "[ERROR]:       <VERSION> missing"
	usage
	exit 7
fi

if [[ -z "$NEXT_VERSION" ]]; then
	echo "[ERROR]:       <NEXT_VERSION> missing"
	usage
	exit 7
fi

if [[ "$TAG" ]]; then
	_MAVEN_OPTS="$_MAVEN_OPTS -Dmaster_release_tagName=$TAG"
fi
_MAVEN_OPTS="$_MAVEN_OPTS -e -B"

mvn -Prelease.setversion -Dmaster_release_newVersion=$VERSION -f maven_plugin_version-master -N $_MAVEN_OPTS
processError

mvn -Prelease.checkin -Declipse_gerrit_username=$GIT_USERNAME -f maven_plugin_version-master $_MAVEN_OPTS
processError

mvn -Prelease.tag -Declipse_gerrit_username=$GIT_USERNAME -Dmaster_release_pushChanges=false -f maven_plugin_version-master $_MAVEN_OPTS
processError

mvn -Prelease.setversion -Dmaster_release_newVersion=$NEXT_VERSION -f maven_plugin_version-master -N $_MAVEN_OPTS -Dmaster_release_tagName="master"
processError

mvn -Prelease.checkin -Declipse_gerrit_username=$GIT_USERNAME -Dmaster_release_pushChanges=false -Dmaster_release_checkinMessage="[release] prepare for next development iteration" -f maven_plugin_version-master $_MAVEN_OPTS
processError