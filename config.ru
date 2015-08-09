#require ::File.expand_path('../start',  __FILE__)
require 'zendesk_api'
require 'pry'
require 'logger'
require 'yaml'
require 'sinatra/base'
require_relative 'config/config'

Dir['app/**/*.rb'].each { |d| require_relative d }

views_dir = File.join( File.expand_path('.'), 'app/views' )
Sinatra::Base.set :views, views_dir

run Rack::Cascade.new [ApplicationController]
