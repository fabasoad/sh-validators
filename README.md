# Shell validators

[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://stand-with-ukraine.pp.ua)
![GitHub release](https://img.shields.io/github/v/release/fabasoad/sh-validators?include_prereleases)
![security](https://github.com/fabasoad/sh-validators/actions/workflows/security.yml/badge.svg)
![linting](https://github.com/fabasoad/sh-validators/actions/workflows/linting.yml/badge.svg)

Shell library to validate user inputs.

## Table of Contents

- [Shell validators](#shell-validators)
  - [Table of Contents](#table-of-contents)
  - [How to use?](#how-to-use)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
  - [Features](#features)
    - [Customization](#customization)
      - [Define exit code](#define-exit-code)
    - [Validators](#validators)
      - [Validate that directory exists](#validate-that-directory-exists)
      - [Validate enum](#validate-enum)
      - [Validate that file exists](#validate-that-file-exists)
      - [Validate semver](#validate-semver)
      - [Validate tool installed](#validate-tool-installed)
  - [Hints](#hints)
  - [Contributions](#contributions)

## How to use?

### Prerequisites

The following tools have to be available on a machine prior using this library:

- [bash >=4.0](https://www.gnu.org/software/bash/)

### Installation

```shell
bpkg install fabasoad/sh-validators
```

See [installation options](https://github.com/bpkg/bpkg?tab=readme-ov-file#installing-packages)
for more details.

## Features

### Customization

#### Define exit code

It is possible to set preferred custom exit code on failure via environment variable:

- **Name**: `FABASOAD_VALIDATORS_CONFIG_EXIT_CODE`.
- **Type**: `number`
- **Default**: `1`

Examples:

```shell
# Default exit code
$ ./fabasoad-validate-dir-exists "./abc"
"./abc" is not a directory or does not exist.
$ echo $?
1
# Custom exit code
$ FABASOAD_VALIDATORS_CONFIG_EXIT_CODE=32 ./fabasoad-validate-dir-exists "./abc"
"./abc" is not a directory or does not exist.
$ echo $?
32
# Invalid exit code
$ FABASOAD_VALIDATORS_CONFIG_EXIT_CODE=invalid ./fabasoad-validate-dir-exists "./abc"
"./abc" is not a directory or does not exist.
$ echo $?
1
```

### Validators

#### Validate that directory exists

Validates that passed value is a path to an existing directory. Examples:

```shell
# Positive case
$ ./fabasoad-validate-dir-exists "this-dir-exists"
$ echo $?
0
# Negative case with passing a file instead of a directory
$ ./fabasoad-validate-dir-exists "this-file-exists.txt"
"this-file-exists.txt" is not a directory or does not exist.
$ echo $?
1
# Negative case without setting parameter name
$ ./fabasoad-validate-dir-exists "this-dir-does-not-exist"
"this-dir-does-not-exist" is not a directory or does not exist.
$ echo $?
1
# Negative case with setting parameter name
$ ./fabasoad-validate-dir-exists "this-dir-does-not-exist" "my-param"
"my-param" parameter is invalid. "this-dir-does-not-exist" is not a directory or does not exist.
$ echo $?
1
```

#### Validate enum

Validates string to be one of the possible values (emulating enum data type).
Examples:

```shell
# Positive case
$ ./fabasoad-validate-enum "true" "true,false"
$ echo $?
0
# Negative case without setting parameter name
$ ./fabasoad-validate-enum "wrong" "true,false"
"wrong" is invalid. Possible values: true, false.
$ echo $?
1
# Negative case with setting parameter name
$ ./fabasoad-validate-enum "wrong" "true,false" "my-param"
"my-param" parameter is invalid. "wrong" is invalid. Possible values: true, false.
$ echo $?
1
```

#### Validate that file exists

Validates that passed value is a path to an existing file. Examples:

```shell
# Positive case
$ ./fabasoad-validate-file-exists "this-file-exists.txt"
$ echo $?
0
# Negative case with passing a directory instead of a file
$ ./fabasoad-validate-file-exists "this-dir-exists"
"this-dir-exists" is not a file or does not exist.
$ echo $?
1
# Negative case without setting parameter name
$ ./fabasoad-validate-file-exists "this-file-does-not-exist.txt"
"this-file-does-not-exist.txt" is not a file or does not exist.
$ echo $?
1
# Negative case with setting parameter name
$ ./fabasoad-validate-file-exists "this-file-does-not-exist.txt" "my-param"
"my-param" parameter is invalid. "this-file-does-not-exist.txt" is not a file or does not exist.
$ echo $?
1
```

#### Validate semver

Validates value to be a valid semver string. Examples:

```shell
# Positive case
$ ./fabasoad-validate-semver "1.2.3"
$ echo $?
0
# Negative case without setting parameter name
$ ./fabasoad-validate-semver "alpha.beta.1"
"alpha.beta.1" is not a valid semver.
$ echo $?
1
# Negative case with setting parameter name
$ ./fabasoad-validate-semver "alpha.beta.1" "my-param"
"my-param" parameter is invalid. "alpha.beta.1" is not a valid semver.
$ echo $?
1
```

#### Validate tool installed

Validates that tool is installed on the machine. Examples:

```shell
# Positive case (assuming jq is installed)
$ ./fabasoad-validate-tool-installed "jq"
$ echo $?
0
# Negative case without setting parameter name
$ ./fabasoad-validate-tool-installed "abc"
"abc" is not installed on the current machine.
$ echo $?
1
# Negative case with setting parameter name
$ ./fabasoad-validate-tool-installed "abc" "my-param"
"my-param" parameter is invalid. "abc" is not installed on the current machine.
$ echo $?
1
```

## Hints

If you want to redirect error message to your internal logic:

```shell
set +e
err_msg=$(./fabasoad-validate-dir-exists "abc" 2>&1 >/dev/null)
exit_code="$?"
if [ "${exit_code}" -ne 0 ]; then
  printf "[ERR] [%s] %s\n" "$(date +'%Y-%m-%d %T')" "${err_msg}"
fi
set -e
exit "${exit_code}"
# Output
[ERR] [2025-01-25 19:11:36] "abc" is not a directory or does not exist.
```

## Contributions

![Alt](https://repobeats.axiom.co/api/embed/edbb31d44e161d6596d5cdd26004b9926e5b49f6.svg "Repobeats analytics image")
