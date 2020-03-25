#!/bin/sh -l
set -eu

TARGET=$(/find_target.rb)

echo "target branch: $TARGET"

git clone https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git $REPO_NAME

cd $(basename $GITHUB_REPOSITORY)
merges=$(git log $TARGET.. --merges --pretty=format:'* %s --- %b' \
  | sed -E 's/Merge pull request (.*) from .* --- /\1: /g' \
  | grep -v -- '---')

/make_comment.rb merges
