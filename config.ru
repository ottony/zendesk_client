require './config/init'

run Rack::Cascade.new [ApplicationController]
