#!/usr/bin/env bash

validate_dir_exists() {
  param_key="$1"
  param_val="$2"
  if [ ! -d "${param_val}" ]; then
    msg="\"${param_key}\" parameter is invalid. \"${param_val}\" is not a directory or does not exist."
    echo "::error title=Invalid parameter::${msg}"
    exit 1
  fi
}

## export
if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f validate_dir_exists
else
  validate_dir_exists "${@}"
  exit $?
fi
