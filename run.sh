#!/usr/bin/env sh
set -e

bin=bin
obj=obj

in=$1
out="${in%.*}"

cpp_version=-std=c++20
warnings="-Wall -Wextra -Wpedantic -Werror -Wno-missing-field-initializers"
input_file=$1
target_dir=bin
include_dir="-I. -I${MINIAUDIO_SDK}"
library_paths="-L./bin -L${MINIAUDIO_SDK}/build"
library="${library_paths} -lminiaudio"
compile_flags="${cpp_version} ${warnings} ${include_dir} ${library}"

# create directories
mkdir -p $bin
mkdir -p $obj

# compile
c++ $compile_flags $in -o $bin/$out

# run
./bin/$out "${@:2}"

