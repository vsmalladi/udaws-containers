#!/bin/bash

# CI Testing Script for U-DAWS-Dockerfiles
#
# Runs tests for changed Dockerfile/unittest.yml file

set -e
source ci/functions.sh

# Check that the Docker Hub organization to use is in the DOCKERHUB_ORG variable
check_org

# Fetch the newest changes for DEPLOY_BRANCH
fetch_master

# Get the range of commits to compare for detecting changed files
compare_range=$(get_compare_range)

# Get a list of changed paths in the repo to look for <tool>/<version>/Dockerfile
paths=$(changed_paths_in_range "$compare_range")

# For all built images run through tests in unittest.yml files are found.
python3 tests/imagecheck.py "$DOCKERHUB_USERNAME" $paths
