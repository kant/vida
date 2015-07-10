#!/bin/bash

set -e

release=v$1
echo "Releasing " $release

cp vida-git-1.rockspec vida-$release.rockspec
repo='git:\/\/github.com\/nwhitehead\/vida\.git'
newrepo="https:\/\/github.com\/nwhitehead\/vida\/archive\/$release.tar.gz"
dir="\'vida\'"
newdir="\'vida-$1\'"

echo $repo
perl -p -e "s/scm/$release/g" < vida-git-1.rockspec \
   | perl -p -e "s/$repo/$newrepo/g" \
   | perl -p -e "s/$dir/$newdir/g" \
    > vida-$release.rockspec

git tag $release
git push origin $release
luarocks upload vida-$release.rockspec
