#!/bin/bash

# CI Testing Script for U-DAWS-Dockerfiles
#
# Runs tests for changed Dockerfile/unittest.yml file

source functions.sh

# See build-ci.sh for explanation of these conventions/rules
check_org

compare_range=$(get_compare_range)
paths=$(changed_paths_in_range "$compare_range")
python3 ../tests/imagecheck.py "$DOCKERHUB_ORG" $paths
