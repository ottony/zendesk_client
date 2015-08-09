class Zendesk
  class << self
    def new_ticket  email: , name: , body: nil, subject: nil, priority: nil, curriculum: nil
      priority ||= 'normal'
      subject  ||= 'Nova análize pendente'
      body     ||= 'Gostaria que meu currículo fosse analizado'

      request = {
        subject:      subject,
        priority:     priority,
        comment:      { value: body },
        requester:    { email: email, name: name }
      }

      ticket = ZendeskAPI::Ticket.new(client, request )
      ticket.comment.uploads << curriculum if curriculum

      ticket
    end

    def create_ticket args = {}
      ticket = new_ticket args
      ticket.save
      ticket
    end

    def add_comment_to_ticket ticket_id, comment
      ticket = client.tickets.find(id: ticket_id)
      return false unless ticket

      ticket.comment = { body: comment }
      ticket.save
    end

    def client
      Config.zendesk_client
    end
  end
end
