class ApplicationController < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/submit' do
    redirect '/obrigado'
  end

  get '/obrigado' do
    erb :thanks
  end
end
