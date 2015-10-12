#Build *Scout Maven Master*

##Prepare the release
  mvn release:prepare -Dtag=v1.3.1 -DreleaseVersion=1.3.1 -DdevelopmentVersion=1.3.2-SNAPSHOT -Dresume=false -B

##Perform the release - publish to BSI Artifactory
  mvn release:perform -Dgoals="clean install" -B -Darguments=""

Without GPG sining add `-Dgpg.skip=true` to `-Darguments`.


