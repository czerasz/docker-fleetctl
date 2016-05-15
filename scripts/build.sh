#!/bin/bash

# Stop on any error
set -e

script_dirirectory="$( cd "$( dirname "$0" )" && pwd )"
project_dirirectory=$script_dirirectory/..

# Load defaults
source $project_dirirectory/.env

# If no variable is set view the usage information
if [ -z $user_id ] && [ -z $version ] && [ -z $image_name ]; then
  echo 'Usage:'
  script_name="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
  echo "user_id=<id> version=<version> image_name=<name> $script_name"
  echo -e "\nWhere:"
  echo '- user_id    - id of the user you plan to work with fleetctl'
  echo '- version    - fleetctl version which should be build'
  echo '- image_name - name of the Docker image'
  echo -e "\n"
fi

# Check if user_id environment variable is set
if [ -z $user_id ]; then
  echo "No user_id variable defined"
  user_id=$(id -u)
  echo -e "Fall back to default (your current user ID) user_id: $user_id\n"
fi

# Check if version environment variable is set
if [ -z "$version" ]; then
  # Set default fleet version
  echo "No version variable defined"
  version=$default_version
  echo -e "Fall back to default version: $version\n"
fi

# Check if image_name environment variable is set
if [ -z $image_name ]; then
  echo "No image_name variable defined"
  image_name=czerasz
  echo -e "Fall back to default image_name: $version\n"
fi

cd $project_dirirectory

# Build the container
docker build --build-arg=FLEET_VERSION=v$version \
             --build-arg=USER_ID=$user_id \
             --tag=$image_name/fleetctl:$version .

echo -e "\nSuccessfully build image $image_name/fleetctl:$version"
