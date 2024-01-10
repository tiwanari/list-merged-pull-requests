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
SOURCE=origin/$(cat $GITHUB_EVENT_PATH | jq -r '.pull_request.head.ref')
echo "Source branch: $SOURCE"

CHANGES=$(git log $TARGET..$SOURCE --first-parent --pretty=format:'%s' \
   | sed -E 's/.*(#[0-9]+).*/\* \[ \] \1/g')
echo "Changes: "
echo "$CHANGES"

# Ignore branch merges
VALID_COMMENTS=$(echo "$CHANGES" | grep '^\* \[ \] #[0-9]\+$' || echo "")
echo "Valid comments: "
echo "$VALID_COMMENTS"

echo "Commenting..."
PR_NUMBER=$(cat $GITHUB_EVENT_PATH | jq -r '.number')
/make_comment.rb "$GITHUB_REPOSITORY" "$PR_NUMBER" "$GITHUB_TOKEN" "$VALID_COMMENTS"
