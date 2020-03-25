#!/bin/sh -l

TARGET=$(sh /find_target.rb)

merges=$(git log $TARGET.. --merges --pretty=format:'* %s --- %b' \
  | sed -E 's/Merge pull request (.*) from .* --- /\1: /g' \
  | grep -v -- '---')

sh /make_comment.rb merges
