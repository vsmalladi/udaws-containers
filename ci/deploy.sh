#!/bin/bash

# CI Deploy Script for U-DAWS-Dockerfiles
#
# Expects to be authenticated to Docker Hub and only run from DEPLOY_BRANCH
# Pushes Docker images and tags to Docker Hub when build-ci.sh has built the image

set -e
source ci/functions.sh

# Check that the Docker Hub organization to use is in the DOCKERHUB_ORG variable
check_org

# Fetch the newest changes for DEPLOY_BRANCH
compare_range=$(get_compare_range)

# Get a list of changed paths in the repo to look for <tool>/<version>/Dockerfile
paths=$(changed_paths_in_range "$compare_range")

# Loop through the changed files and build Docker images for any that match
# <tool>/<version>/Dockerfile. If none found, prints a message indicating so.
# Push images that have changed to Docker hub.
build_images "$DOCKERHUB_ORG" "$paths"
push_images "$DOCKERHUB_ORG" "$paths"
