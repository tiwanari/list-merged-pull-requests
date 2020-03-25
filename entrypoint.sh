#!/bin/sh -l
set -eu

CURRENT_DIR=$(pwd)
TARGET=$($CURRENT_DIR/find_target.rb)

merges=$(git log $TARGET.. --merges --pretty=format:'* %s --- %b' \
  | sed -E 's/Merge pull request (.*) from .* --- /\1: /g' \
  | grep -v -- '---')

$CURRENT_DIR/make_comment.rb merges
