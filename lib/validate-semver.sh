#!/usr/bin/env bash

validate_semver() {
  param_key="${1}"
  param_val="${2}"
  semver_regex="^[0-9]\+\(\.[0-9]\+\)\{0,2\}\(-[0-9A-Za-z-]\+\(\.[0-9A-Za-z-]\+\)*\)\?\(\+[0-9A-Za-z-]\+\(\.[0-9A-Za-z-]\+\)*\)\?$"
  if ! expr "${param_val}" : "${semver_regex}" >/dev/null; then
    printf "\"%s\" parameter is invalid. \"%s\" is not a valid semver.\n" "${param_key}" "${param_val}" >&2
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
