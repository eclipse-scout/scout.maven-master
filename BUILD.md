#Build

##Prepare the release
	mvn release:prepare -Dtag=v1.3 -DreleaseVersion=1.3 -DdevelopmentVersion=1.4-SNAPSHOT -Dresume=false -B

##Perform the release - publish to BSI Artifactory
	mvn release:perform -Dgoals="clean install" -B

Without GPG sining add `-Dgpg.skip=true` to `-Darguments`.

** Scout Parent **

