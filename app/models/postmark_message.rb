# frozen_string_literal: true

require 'mail'

class PostmarkMessage
  def initialize(message)
    @message = message
  end

  def receivers
    @message[:to].map { |hash| hash['Name'] }
  end

  def sender
    Mail::Address.new(@message[:from]).display_name
  end

  def subject
    @message[:subject]
  end
end
