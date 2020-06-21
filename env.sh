#!/bin/bash

# https://stackoverflow.com/a/21188136
get_abs_dirname() {
  # $1 : relative filename
  echo "$(cd "$(dirname "$1")" && pwd)"
}

export AWS_CONFIG_FILE=$(get_abs_dirname "$0")/.aws.conf
echo $AWS_CONFIG_FILE
