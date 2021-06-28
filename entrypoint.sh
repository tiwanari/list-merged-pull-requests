#!/bin/sh -l
set -eu

GITHUB_TOKEN=$1

if [ $GITHUB_EVENT_NAME != 'pull_request' ]; then
  echo "This action only supports Pull Request events"
  exit 1
fi


git clone https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
cd $(basename "$GITHUB_REPOSITORY")

TARGET=origin/$(cat $GITHUB_EVENT_PATH | jq -r '.pull_request.base.ref')
echo "Target branch: $TARGET"

CHANGES=$(git log $TARGET.. --merges --pretty=format:'* [ ] %s' \
   | sed -E 's/Merge pull request (.*) from .*/\1 /g')
echo "Changes: "
echo "$CHANGES"

VALID_COMMENTS=$(echo "$CHANGES" | grep -v -- '---')
echo "Valid comments: "
echo "$VALID_COMMENTS"

echo "Commenting..."
PR_NUMBER=$(cat $GITHUB_EVENT_PATH | jq -r '.number')
/make_comment.rb "$GITHUB_REPOSITORY" "$PR_NUMBER" "$GITHUB_TOKEN" "$VALID_COMMENTS"
