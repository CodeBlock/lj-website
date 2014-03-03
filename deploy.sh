#!/usr/bin/env bash

cwd="$( cd "${BASH_SOURCE[0]%/*}" && pwd )"

if [ ! -f "$cwd/dist/build/lambdajam/lambdajam" ]; then
  echo "lambdajam binary not found."
  exit 1
fi

"$cwd/dist/build/lambdajam/lambdajam" clean
"$cwd/dist/build/lambdajam/lambdajam" build

if [ ! -d "$cwd/_site" ]; then
  echo "_site not found."
  exit 1
fi

dir="$(mktemp -d)"
cp -r _site "$dir"
pushd "$dir"
git clone git@github.com:CodeBlock/lj-website.git
cd lj-website
git checkout gh-pages
shopt -s extglob
rm -rfv !(CNAME)
mv ../_site/* .
git add .
git commit -m "Deploy"
git push origin gh-pages
popd
rm -rfv "$dir"
