#!/bin/bash

# CI Deploy Script for U-DAWS-Dockerfiles
#
# Expects to be authenticated to Docker Hub and only run from DEPLOY_BRANCH
# Pushes Docker images and tags to Docker Hub when build-ci.sh has built the image

set -e
source ci/functions.sh

# See build-ci.sh for explanation of these conventions/rules
check_org

compare_range=$(get_compare_range)
paths=$(changed_paths_in_range "$compare_range")

build_images "$DOCKERHUB_ORG" "$paths"
push_images "$DOCKERHUB_ORG" "$paths"
