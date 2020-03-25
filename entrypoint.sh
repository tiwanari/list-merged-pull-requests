#!/bin/sh -l
set -eu

TARGET=$(/find_target.rb)

merges=$(git log $TARGET.. --merges --pretty=format:'* %s --- %b' \
  | sed -E 's/Merge pull request (.*) from .* --- /\1: /g' \
  | grep -v -- '---')

/make_comment.rb merges
