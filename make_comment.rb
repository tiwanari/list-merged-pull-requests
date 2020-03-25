#!/usr/bin/env ruby
require 'json'
require 'octokit'

github_token = ARGV[0].strip
message = ARGV[1].strip

if message.empty?
  puts 'No merged pull requests'
  exit 0
end

event = JSON.parse(File.read(ENV.fetch('GITHUB_EVENT_PATH')))

GITHUB = Octokit::Client.new(access_token: github_token)
GITHUB.add_comment(ENV.fetch('GITHUB_REPOSITORY'), event['number'], message)
