#!/usr/bin/env sh

bin="${BIN:-fabasoad}"
target_path="${PREFIX:-/usr/local}"
target_bin="${target_path}/bin"
cmds="validate-dir-exists validate-enum validate-file-exists validate-semver"
