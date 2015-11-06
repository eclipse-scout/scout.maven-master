#Build *Scout Maven Master*

##Prepare the release
  mvn -Prelease clean release:clean release:prepare -Dtag=v1.6.1 -DreleaseVersion=1.6.1 -DdevelopmentVersion=1.6.2-SNAPSHOT -Dresume=false -B

##Perform the release - publish to BSI Artifactory
  mvn -Prelease release:perform -Dgoals="clean install" -B -Darguments=""

Without GPG sining add `-Dgpg.skip=true` to `-Darguments`.
