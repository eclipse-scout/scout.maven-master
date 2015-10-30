#Build *Scout Maven Master*

##Prepare the release
  mvn release:prepare -Dtag=v1.6 -DreleaseVersion=1.6 -DdevelopmentVersion=1.7-SNAPSHOT -Dresume=false -B

##Perform the release - publish to BSI Artifactory
  mvn release:perform -Dgoals="clean install" -B -Darguments=""

Without GPG sining add `-Dgpg.skip=true` to `-Darguments`.
