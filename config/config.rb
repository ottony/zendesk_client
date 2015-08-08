module Config
  def self.zendesk_client
    zendesk_config = YAML.load_file('config/zendesk.yml')

    @zendesk_client ||= ZendeskAPI::Client.new do |config|
      config.url      = zendesk_config['url']
      config.username = zendesk_config['username']
      config.password = zendesk_config['password']
      config.retry    = zendesk_config['retry']
    end
  end
end
