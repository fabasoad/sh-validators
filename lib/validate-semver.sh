#!/usr/bin/env bash

validate_semver() {
  param_key="$1"
  param_val="$2"
  semver_regex="^[0-9]\+\(\.[0-9]\+\)\{0,2\}\(-[0-9A-Za-z-]\+\(\.[0-9A-Za-z-]\+\)*\)\?\(\+[0-9A-Za-z-]\+\(\.[0-9A-Za-z-]\+\)*\)\?$"
  if ! expr "${param_val}" : "${semver_regex}" >/dev/null; then
    msg="\"${param_key}\" parameter is invalid. \"${param_val}\" is not a valid semver."
    echo "::error title=Invalid parameter::${msg}"
    exit 1
  fi
}

## export
if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f validate_semver
else
  validate_semver "${@}"
  exit $?
fi
