class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    pp message
    group = message.group
    p "group: ", group
    ActionCable.server.broadcast("room_channel_#{group.id}", {message: render_message(message)})
  end

  private
  def render_message(message)
    ApplicationController.render_with_signed_in_user(message.user, partial: 'messages/message', locals: { message: message })
    # ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
