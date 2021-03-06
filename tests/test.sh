#!/usr/bin/env bash
set -e

basedir="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )"

if [ "$SUITE" = "phpunit" ];
then
    testcmd="bin/moodle-docker-compose exec -T webserver vendor/bin/phpunit --filter core_dml_testcase"
elif [ "$SUITE" = "behat" ];
then
    testcmd="bin/moodle-docker-compose exec -T webserver php admin/tool/behat/cli/run.php --tags=@auth_manual"
elif [ "$SUITE" = "phpunit-full" ];
then
    testcmd="bin/moodle-docker-compose exec -T webserver vendor/bin/phpunit --verbose"
elif [ "$SUITE" = "behat-app" ] || [ "$SUITE" = "behat-app-development" ];
then
    testcmd="bin/moodle-docker-compose exec -T webserver php admin/tool/behat/cli/run.php --tags=@app&&@mod_login"
else
    echo "Error, unknown suite '$SUITE'"
    exit 1
fi

echo "Running: $testcmd"
$basedir/$testcmd
