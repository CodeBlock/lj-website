#!/usr/bin/env bash

cwd="$( cd "${BASH_SOURCE[0]%/*}" && pwd )"

if [ ! -f "$cwd/dist/build/lambdajam/lambdajam" ]; then
  echo "lambdajam binary not found."
  exit 1
fi

"$cwd/dist/build/lambdajam/lambdajam" watch
