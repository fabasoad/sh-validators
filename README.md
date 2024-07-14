# Shell validators

Shell library to validate user inputs.

## Supported validators

1. [Validate that directory exists](./lib/validate-dir-exists.sh)
2. [Validate enum](./lib/validate-enum.sh)
3. [Validate that file exists](./lib/validate-file-exists.sh)
4. [Validate semver](./lib/validate-semver.sh)

## Installation

```shell
bpkg install fabasoad/sh-validators
```

More information on installation options you can find [here](https://github.com/bpkg/bpkg?tab=readme-ov-file#installing-packages).

## Examples

Use script by running file:

```shell
mkdir "this-dir-exists"
./validate-dir-exists "dir-param" "this-dir-exists"
echo $?
# Output
0
```

Use script by running function:

```shell
. "./validate-dir-exists"
mkdir "this-dir-exists"
validate_dir_exists "dir-param" "this-dir-exists"
echo $?
# Output
0
```

Negative use case:

```shell
./validate-dir-exists "dir-param" "this-dir-does-not-exist"
# Output
"dir-param" parameter is invalid. "<full-path>/this-dir-does-not-exist" is not a directory or does not exist.
```

If you want to redirect error message to your internal logic:

```shell
set +e
err_msg=$(./validate-dir-exists.sh "dir-param" "this-dir-does-not-exist" 2>&1 >/dev/null)
if [ "$?" -ne 0 ]; then
  echo "[error] $(date +%s) $err_msg"
fi
# Output
[error] 1720946407 "dir-param" parameter is invalid. "<full-path>/this-dir-does-not-exist" is not a directory or does not exist.
```
