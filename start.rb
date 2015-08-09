require 'zendesk_api'
require 'pry'
require 'logger'
require 'yaml'
#require 'sinatra'
require_relative 'config/config'

Dir['app/**/*.rb'].each { |d| require_relative d }
#binding.pry
