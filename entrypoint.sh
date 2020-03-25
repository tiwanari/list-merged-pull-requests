#!/bin/sh -l
set -eu

export GITHUB_TOKEN=$0

TARGET=$(/find_target.rb)

echo "target branch: $TARGET"

whoami

ls -al
mkdir test

git clone https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git

cd $(basename $GITHUB_REPOSITORY)
merges=$(git log origin/$TARGET.. --merges --pretty=format:'* %s --- %b' \
  | sed -E 's/Merge pull request (.*) from .* --- /\1: /g' \
  | grep -v -- '---')

/make_comment.rb merges
