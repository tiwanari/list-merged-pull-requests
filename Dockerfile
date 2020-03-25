FROM ruby:2.7.0-alpine

RUN apk update && \
    apk upgrade && \
    apk add --no-cache git jq

RUN gem install octokit

COPY entrypoint.sh /entrypoint.sh
COPY src/make_comment.rb /make_comment.rb

ENTRYPOINT ["/entrypoint.sh"]
