#Build *Scout Maven Master*

##Perform the release - push tag and branch to Eclipse Gerrit
  shell_scripts/release.sh -u sleicht -r 2.0.1 -d 2.0.2-SNAPSHOT -t v2.0.1

##Change Version
  mvn versions:set -DnewVersion=2.0-SNAPSHOT
  mvn versions:set -DnewVersion=2.0-SNAPSHOT -f maven_plugin_version-master/pom.xml
