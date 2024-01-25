class RoomChannel < ApplicationCable::Channel
  def subscribed
    p "params:"
    pp params
    stream_from "room_channel_#{params['group']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # jsで実行されたspeakのmessageを受け取り、room_channelのreceivedにブロードキャストする
    # ActionCable.server.broadcast 'room_channel', message: data['message']
    # Message.create!({content: data['message'], user_id: current_user.id, group_id: data['group_id']})
    p "current_user:"
    pp current_user
    Message.create!({content: data['message'], user_id: params['user'], group_id: params['group']})
  end
end
