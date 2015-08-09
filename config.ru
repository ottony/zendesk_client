#require ::File.expand_path('../start',  __FILE__)
require 'zendesk_api'
require 'pry'
require 'logger'
require 'yaml'
require_relative 'config/config'

Dir['app/**/*.rb'].each { |d| require_relative d }

run Rack::Cascade.new [ApplicationController]
