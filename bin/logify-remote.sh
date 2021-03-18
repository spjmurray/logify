#!/bin/bash
# Simple script to wrap a call to grab the logs from Jenkins, extract the relevant bits and then logify them all in one go.
set -euxo pipefail
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Recommendation is to use an API token here, ideally set via a variable to save having to do it over & over.
JENKINS_CREDENTIALS=${JENKINS_CREDENTIALS:-$1}
# Provide the test case name you want to logify.
TEST_CASE=${TEST_CASE:-$2}
# Provide the test number so we can construct the Jenkins URL - ignored if you provide JENKINS_URL directly.
TEST_NUMBER=${TEST_NUMBER:-$3}

LOGIFY_BINARY=${LOGIFY_BINARY:-${SCRIPT_DIR}/logify}
JENKINS_URL=${JENKINS_URL:-https://jenkins.spjmurray.co.uk/job/couchbase-operator-continuous-integration/$2/artifact/logs.tar.gz}
CURL=${CURL:-curl --silent --show-error --fail --output ./logs.tgz}

LOG_DIR=$(mktemp -d)
pushd "${LOG_DIR}"
    ${CURL} --url ${JENKINS_URL} --user ${JENKINS_CREDENTIALS}
    tar -xzvf ./logs.tgz
    LATEST_DIR=$(ls -td -- */ | head -n 1 | cut -d'/' -f1)
    TEST_CASE_DIR=$(find "${LOG_DIR}/${LATEST_DIR}" -type d -name "${TEST_CASE}")
    CBOPINFO_ARCHIVE=$(find "${TEST_CASE_DIR}" -type f -name "cbopinfo*.tar.gz")
    tar -xzvf "${CBOPINFO_ARCHIVE}" -C ./
    "${LOGIFY_BINARY}" $(ls -d1 cbopinfo*)
popd
rm -rf "${LOG_DIR}"