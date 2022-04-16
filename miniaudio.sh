#!/usr/bin/env sh
set -e

input=miniaudio.c
output="${input%.*}"

c_version=-std=c18
warnings="-Wall -Wextra"
include_dir="-I. -I${MINIAUDIO_PATH}"
compile_flags="${c_version} ${warnings} ${include_dir}"

binary=bin
object=obj
mkdir -p $binary
mkdir -p $object

cc $compile_flags -c $input -o $object/${output}
ar rcs $binary/lib${output}.a $object/${output}

