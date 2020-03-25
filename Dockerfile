FROM ruby:2.7-alpine

RUN gem install octokit

COPY entrypoint.sh /entrypoint.sh
COPY find_target.rb /find_target.rb
COPY make_comment.rb /make_comment.rb

ENTRYPOINT ["/entrypoint.sh"]