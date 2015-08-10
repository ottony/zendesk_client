require 'ostruct'

module Config
  def self.load!
    zendesk_client
    uploader
  end

  def self.zendesk_client
    return @zendesk_client if @zendesk_client

    zendesk_config = YAML.load_file('config/zendesk.yml')

    @zendesk_client   = ZendeskAPI::Client.new do |config|
      config.url      = zendesk_config['url']
      config.username = zendesk_config['username']
      config.password = zendesk_config['password']
      config.retry    = zendesk_config['retry']
    end
  end

  def self.uploader
    return @uploader if @uploader

    store_dir = File.join File.expand_path( Dir.pwd ), 'public/uploads'
    cache_dir = File.join File.expand_path( Dir.pwd ), 'tmp/uploads'

    @uploader = OpenStruct.new({
      store_dir: store_dir,
      cache_dir: cache_dir
    })
  end

  def self.domain
    'http://vagasempregosrn.com.br/'
  end
end
