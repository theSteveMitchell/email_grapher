
class Snapshot < ApplicationRecord
  serialize :data, JSON

  def self.take
    people = Set.new
    conversations = ConversationMap.new

    postmark_messages.each do |message_hash|
      message = PostmarkMessage.new(message_hash)
      people.add(message.sender)
      message.receivers.each do |receiver|
        people.add(receiver)
        conversations.push_topic(message.sender, receiver, message.subject)
      end
    end

    @data = { 
      nodes: people.map{|u| {id: u}}, 
      links: conversations.to_hash
    }

    Snapshot.new(data: @data)
  end

  def self.postmark_messages
    client = Postmark::ApiClient.new(Rails.application.config.x.postmark.api_token)

    # https://github.com/wildbit/postmark-gem/blob/master/lib/postmark/api_client.rb#L107
    # APIClient#messages is only lightly documented, but this one handles batching and supports options like batch_size
    client.messages(max_batch_size: 100)
  end
end
