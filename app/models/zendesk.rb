class Zendesk
  class << self
    def new_ticket  client: , body: nil, subject: nil, priority: nil, upload: false, download_path: nil
      priority ||= 'normal'
      subject  ||= "#{client.name} - Análise currículo"
      body     ||= "Gostaria que meu currículo fosse analizado\n"
      body     <<  "Faça o download aqui: #{ download_path }\n" if download_path
      body     <<  "Mensagem automática #{Time.now}"

      request = {
        subject:      subject,
        priority:     priority,
        comment:      { value: body },
        requester:    { email: client.email, name: client.name }
      }

      ticket = ZendeskAPI::Ticket.new(api_client, request )
      ticket.comment.uploads << client.curriculum if upload and client.curriculum

      ticket
    end

    def create_ticket args = {}
      ticket = new_ticket args
      ticket.save
      ticket
    end

    def add_comment_to_ticket ticket_id, comment
      ticket = api_client.tickets.find(id: ticket_id)
      return false unless ticket

      ticket.comment = { body: comment }
      ticket.save
    end

    def api_client
      Config.zendesk_client
    end
  end
end
