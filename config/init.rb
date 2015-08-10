require 'zendesk_api'
require 'pry'
require 'logger'
require 'yaml'
require 'carrierwave'
require 'sinatra/base'
require_relative 'config'

Dir['app/**/*.rb'].each { |d| require File.expand_path(d) }

views_dir = File.join( File.expand_path('.'), 'app/views' )
Sinatra::Base.set :views, views_dir
