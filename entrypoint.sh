#!/bin/sh -l
set -eu

GITHUB_TOKEN=$0

git clone https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
cd $(basename $GITHUB_REPOSITORY)


TARGET=origin/$(/find_target.rb)
echo "Target branch: $TARGET"

CHANGES=$(git log $TARGET.. --merges --pretty=format:'* %s --- %b' \
   | sed -E 's/Merge pull request (.*) from .* --- /\1: /g')

echo "Changes: "
echo "$CHANGES"

VALID_COMMENTS=$(echo "$CHANGES" | grep -v -- '---')

echo "Valid comments: "
echo "$VALID_COMMENTS"

echo "Commenting..."
/make_comment.rb "$GITHUB_TOKEN" "$VALID_COMMENTS"
