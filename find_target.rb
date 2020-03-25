#!/usr/bin/env ruby
require 'json'

event = JSON.parse(File.read(ENV.fetch('GITHUB_EVENT_PATH')))

if ENV.fetch('GITHUB_EVENT_NAME') != 'pull_request' && event['action'] == 'opened'
  puts 'This action only supports Pull Request open events'
  exit 1
end

puts "#{event['pull_request']['base']['ref']}"
