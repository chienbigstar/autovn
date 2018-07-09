class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(channel, message)
  end
end