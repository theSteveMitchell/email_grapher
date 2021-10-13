
# ConversationMap is a list of topics discussed between two people
# to initialize: 
# c = ConversationMap.new
# c.push_topic("Harry", "Sally", "Bears")
# c.to_hash
# => [{source: "Harry", target: "Sally", topics: ["Bears"]}]
# 
# sender/receiver are unordered. c.push_topic("a", "b", "c") is equivalent to c.push_topic("b", "a", "c")
# topics are unique to the two people, adding a topic mutliple times will not have any effect.
class ConversationMap < Hash
  def initialize
    super
  end

  def push_topic(sender, receiver, topic)
    key = composite_key(sender, receiver)
    if self[key].present?
      self[key].add(topic)
    else
      self[key] = Set.new([topic])
    end
    self
  end

  def to_hash
    self.keys.map do |key|
      {source: key[0], target: key[1], topics: self[key].to_a}
    end
  end

  private

  def composite_key(sender, receiver)
    if sender < receiver
      [sender, receiver]
    else
      [receiver, sender]
    end
  end 
end
