class ChatService
  MESSAGE_PROPOSAL = "aceitei sua proposta, vamos conversar!"

  def self.start_chat_with_proposal(user, advertisement)
    Message.create!(text: MESSAGE_PROPOSAL, user: user, advertisement: advertisement, status: 0)
  end

  def self.send_message(user, advertisement, message)
    message = Message.new(text: message, user: user, advertisement: advertisement, status: 1)
    message.save
  end
end
