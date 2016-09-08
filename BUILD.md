# Build *Scout Maven Master*

## Perform the release - push tag and branch to Eclipse Gerrit
  shell_scripts/release.sh -u sleicht -r 2.0.9 -d 2.0.10-SNAPSHOT -t v2.0.9

Note that a *FileNotFoundException* for 'maven_plugin_version-master\maven_plugin_version-master' is expected and can be ignored if the build succeeds.

## Change Version
  mvn versions:set -DnewVersion=3.0-SNAPSHOT
  mvn versions:set -DnewVersion=3.0-SNAPSHOT -f maven_plugin_version-master/pom.xml
