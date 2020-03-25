#!/usr/bin/env ruby
require 'json'
require 'octokit'

if ARGV.empty?
  puts 'Missing message argument'
  exit 1
end
message = ARGV[0]

event = JSON.parse(File.read(ENV.fetch('GITHUB_EVENT_PATH')))

GITHUB = Octokit::Client.new(access_token: ENV.fetch('GITHUB_TOKEN'))
GITHUB.add_comment(ENV.fetch('GITHUB_REPOSITORY'), event['number'], message)
