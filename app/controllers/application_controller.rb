class ApplicationController < Sinatra::Base
  get '/' do
    @client = Client.build
    erb :index
  end

  post '/' do
    @client = Client.new client_params

    if @client.save
      redirect '/obrigado'
    else
      @alert = 'Requisição inválida, verifique e tente novamente'
      erb :index
    end
  end

  get '/obrigado' do
    erb :thanks
  end

  private

  def client_params
    selected = params.select { |k, v| permited_params.include? k.to_sym }
    selected[:curriculum] = params[:curriculum][:tempfile] if params[:curriculum]

    selected.symbolize_keys
  end

  def permited_params
    [ :email, :name, :cpf ]
  end
end
