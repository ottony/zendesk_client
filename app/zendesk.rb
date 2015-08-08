class Zendesk
  class << self
    def new_ticket  email: , name: , body: nil, subject: nil, priority: nil, curriculum: nil
      priority ||= 'normal'
      subject  ||= 'Nova análize pendente'
      body     ||= 'Gostaria que meu currículo fosse analizado'

      request = {
        subject:      subject,
        priority:     priority,
        submitter_id: submitter_id,
        comment:      { value: body },
        requester:    { email: email, name: name }
      }

      ticket = ZendeskAPI::Ticket.new(client, request )
      ticket.comment.uploads << curriculum if curriculum

      ticket
    end

    def create_ticket args = {}
      new_ticket(args).save
    end

    def client
      Config.zendesk_client
    end

    def submitter_id
      Config.zendesk_client.current_user.id
    end
  end
end
