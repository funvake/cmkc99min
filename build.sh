#!/usr/bin/env bash
#
# Clean, build `Release` version & run current ‹project› (this directory).
#
# Requires bash, and assumes the executable will be in `bin/Release` with
# the same name as the ‹project› directory name. Arguments passed to this
# script, will be passed to the executable. Modify as necessary.
#
# This script can be run in a `.replit` file on https://repl.it with:
# `run = "exec bash build.sh"`.
#
# Set `BUILD_TYPE` below to `Debug` if a `Release` build is not required.
#
# BUILD_TYPE=Debug
BUILD_TYPE=Release
PRJ=${PWD##*/}

# Delete the `bin` and `build` directories. The following five lines can
# be commented out, once the build files have been generated.
#
[ -d ./bin ] && rm -rf ./bin
[ -d ./build ] && rm -rf ./build
mkdir build; cd build
printf "GENERATING BUILD FILES\n"
cmake .. -G "Ninja" -DCMAKE_BUILD_TYPE=$BUILD_TYPE

# Or, use the following code that assumes the build files are generated
# and correct, if the `./build` subdirectory already exists.
#
# if [ ! -d "./build" ]; then
#    mkdir build; cd build
#    printf "GENERATING BUILD FILES\n"
#    cmake .. -G "Ninja" -DCMAKE_BUILD_TYPE=$BUILD_TYPE
# fi

# Build the project from the `./build` directory. Set current directory
# to the `./build` directory, in case above lines were commented out.
#
2> /dev/null cd build
printf "BUILD PROJECT - ${BUILD_TYPE}\n"
if (cmake --build . --config Release); then
   clear
   printf "RUNNING: ../bin/Release/$PRJ "
   echo "$@"
   printf "\n"
   ../bin/$BUILD_TYPE/$PRJ "$@"
fi
