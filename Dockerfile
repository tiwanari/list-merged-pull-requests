FROM circleci/ruby:2.7.0

RUN gem install octokit

ENV APP_ROOT /var/workflow
WORKDIR $APP_ROOT

COPY entrypoint.sh $APP_ROOT/entrypoint.sh
COPY find_target.rb $APP_ROOT/find_target.rb
COPY make_comment.rb $APP_ROOT/make_comment.rb

ENTRYPOINT ["./entrypoint.sh"]
