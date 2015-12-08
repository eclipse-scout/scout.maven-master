#Build *Scout Maven Master*

##Prepare the release
  mvn -Prelease clean release:clean release:prepare -Dtag=v1.7.1 -DreleaseVersion=1.7.1 -DdevelopmentVersion=1.7.2-SNAPSHOT -Dresume=false -B -Darguments="-Dgpg.skip=true"

##Perform the release - publish to BSI Artifactory
  mvn -Prelease release:perform -Dgoals="clean install" -B -Darguments=""
