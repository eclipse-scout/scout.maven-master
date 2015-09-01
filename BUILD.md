#Build

##Prepare the release
	mvn release:prepare -Dtag=parent/v1.1 -DreleaseVersion=1.1 -DdevelopmentVersion=1-SNAPSHOT -Dresume=false -B

##Perform the release - publish to BSI Artifactory
	mvn release:perform -Dgoals="clean install" -B

Without GPG sining add `-Dgpg.skip=true` to `-Darguments`.

** Scout Parent **

