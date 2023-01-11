# Build Eclipse Scout Maven-Master

## Snapshot build

Use the [SnapshotBuild Jenkins Job](https://ci.eclipse.org/scout/view/Master%20Releng/job/org.eclipse.scout_maven-master_snapshotBuild/)

or use the following Maven command:

    mvn clean install -Dmaster_unitTest_skip=true -Dmaster_webTest_skip=true -Dmaster_sanityCheck_skip=true -Dmaster_coverage_skip=true -Dmaster_deployAtEnd=false -Dmaster_flatten_skip=true

## Release build

Use the [ReleaseBuild_ossrh Jenkins Job](https://ci.eclipse.org/scout/view/Master%20Releng/job/org.eclipse.scout_maven-master_releaseBuild_ossrh/).
