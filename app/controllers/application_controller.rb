class ApplicationController < Sinatra::Base
  get '/' do
    @client = Client.new email: '', name: ''
    erb :index
  end

  post '/submit' do
    @client = Client.new client_params
    @client.save

    redirect '/obrigado'
  end

  get '/obrigado' do
    erb :thanks
  end

  private

  def client_params
    selected = params.select { |k, v| permited_params.include? k.to_sym }
    selected[:curriculum] = params[:curriculum][:tempfile]

    selected.symbolize_keys
  end

  def permited_params
    [ :email, :name, :cpf ]
  end
end
