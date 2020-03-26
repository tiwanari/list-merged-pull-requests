#!/usr/bin/env ruby
# frozen_string_literal: true

require 'octokit'

if ARGV.length < 4
  puts 'Error: Too few arguments'
  puts "Usage: #{__FILE__} repository number token message"
  puts "e.g., #{__FILE__} tiwanari/list-merged-pull-requests 44 *** \"hello\""
  exit 1
end

args = ARGV.map(&:strip)
repository = args[0]
number = args[1]
token = args[2]
message = args[3]

if message.empty?
  puts 'No merged pull requests'
  exit 0
end

GITHUB = Octokit::Client.new(access_token: token)
GITHUB.add_comment(repository, number, message)
