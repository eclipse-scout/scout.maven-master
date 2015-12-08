#!/bin/sh

export MAVEN_OPTS="$MAVEN_OPTS -Xmx256m"

echo ''
echo ''
echo '                 uuuuuuu'
echo '             uu$$$$$$$$$$$uu'
echo '          uu$$$$$$$$$$$$$$$$$uu'
echo '         u$$$$$$$$$$$$$$$$$$$$$u'
echo '        u$$$$$$$$$$$$$$$$$$$$$$$u'
echo '       u$$$$$$$$$$$$$$$$$$$$$$$$$u'
echo '       u$$$$$$$$$$$$$$$$$$$$$$$$$u'
echo '       u$$$$$$"   "$$$"   "$$$$$$u'
echo '       "$$$$"      u$u       $$$$"'
echo '        $$$u       u$u       u$$$'
echo '        $$$u      u$$$u      u$$$'
echo '         "$$$$uu$$$   $$$uu$$$$"'
echo '          "$$$$$$$"   "$$$$$$$"'
echo '            u$$$$$$$u$$$$$$$u'
echo '             u$"$"$"$"$"$"$u'
echo '  uuu        $$u$ $ $ $ $u$$       uuu'
echo ' u$$$$        $$$$$u$u$u$$$       u$$$$'
echo '  $$$$$uu      "$$$$$$$$$"     uu$$$$$$'
echo 'u$$$$$$$$$$$uu    """""    uuuu$$$$$$$$$$'
echo '$$$$"""$$$$$$$$$$uuu   uu$$$$$$$$$"""$$$"'
echo ' """      ""$$$$$$$$$$$uu ""$"""'
echo '           uuuu ""$$$$$$$$$$uuu'
echo '  u$$$uuu$$$$$$$$$uu ""$$$$$$$$$$$uuu$$$'
echo '  $$$$$$$$$$""""           ""$$$$$$$$$$$"'
echo '   "$$$$$"                      ""$$$$""'
echo '     $$$"                         $$$$"'
echo ''
echo ''
echo '           TESTS ARE DISABLED'
echo '               ARE U CRAZY ?'
echo ''
echo ''
echo ''

# Parallel executions of maven modules and tests.
# Half of CPU core are used in to keep other half for OS and other programs.

mvn clean install -T0.5C -B -e -Dmaster_unitTest_skip=true -Dmaster_webTest_skip=true -Dmaster_coverage_skip=true -Dmaster_sanityCheck_skip=true -Dmaster_coverage_skip=true -Dmaster_flatten_skip=true $*
