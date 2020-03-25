#!/bin/sh -l
set -eu

GITHUB_TOKEN=$0

TARGET=origin/$(/find_target.rb)

echo "target branch: $TARGET"

git clone https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY} || true

cd $(basename $GITHUB_REPOSITORY)
CHANGES=$(git log $TARGET.. --merges --pretty=format:'* %s --- %b')

echo "changes: "
echo "$CHANGES"

FIX_FORMAT=$(echo "$CHANGES" \
  | sed -E 's/Merge pull request (.*) from .* --- /\1: /g')

echo "fix format: "
echo "$FIX_FORMAT"

IGNORE_GARBAGE=$(echo "$FIX_FORMAT" \
  | grep -v -- '---')

echo "ignore garbage: "
echo "$IGNORE_GARBAGE"

echo "Commenting..."
/make_comment.rb "$GITHUB_TOKEN" "$IGNORE_GARBAGE"
