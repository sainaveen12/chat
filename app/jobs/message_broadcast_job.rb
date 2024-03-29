class MessageBroadcastJob < ApplicationJob
	queue_as :default
	
	def perform(message)
		sender = message.user
		recipient = message.conversation.opposed_user(sender)

		broadcast_to_sender(sender, message)
		broadcast_to_recipient(recipient, message)
	end

	private

	def broadcast_to_sender(user, message)
		puts "=================="
		puts "1111111111"
		ActionCable.server.broadcast(
			"conversations-#{user.id}",
			message: message,
			conversation_id: message.conversation_id
		)
	end

	def broadcast_to_recipient(user, message)
		puts "=================="
		puts "222222222"
		ActionCable.server.broadcast(
			"conversations-#{user.id}",
			message: render_message(message, user),
			conversation_id: message.conversation_id
		)
	end

	def render_message(message, user)
		puts "=================="
		puts "3333333333"
		ApplicationController.render(
			partial: 'messages/message',
			locals: { message: message, user: user }
		)
	end
end