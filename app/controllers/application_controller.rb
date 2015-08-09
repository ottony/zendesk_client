require 'sinatra/base'

class ApplicationController < Sinatra::Base
  get '/' do
    'Teste'
  end
end
