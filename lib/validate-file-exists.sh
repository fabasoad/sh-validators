#!/usr/bin/env bash

validate_file_exists() {
  param_key="${1}"
  param_val="${2}"
  if [ ! -f "${param_val}" ]; then
    printf "\"%s\" parameter is invalid. \"%s\" is not a file or does not exist.\n" "${param_key}" "${param_val}" >&2
    exit 1
  fi
}

## export
if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f validate_file_exists
else
  validate_file_exists "${@}"
  exit $?
fi
