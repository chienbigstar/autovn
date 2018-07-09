class RoomChannel < ApplicationCable::Channel
  def subscribed
    user = self.current_user
    if user
      ip = self.ip
      stream_from "room_channel_#{user.id}_#{ip}"
    else
      stream_from "stop_room_channel_#{ip}"
      ActionCable.server.broadcast "room_channel__#{user.ip}", message: 'stop'
    end
  end

  def unsubscribed
  end

  def speak(data)
  end
end