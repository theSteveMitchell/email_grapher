require 'rails_helper'

describe ConversationMap do
  describe ConversationMap.new do
    it {is_expected.to eq Hash.new}
  end

  describe ConversationMap.new.push_topic("a", "b", "c") do
    it {is_expected.to eq ConversationMap.new.push_topic("b", "a", "c").push_topic("b", "a", "c")}
    it {is_expected.to eq ConversationMap.new.push_topic("b", "a", "c")}
    it {is_expected.to be_a Hash}
  end

  describe ConversationMap.new.push_topic("a", "b", "c").to_hash do
    it {is_expected.to eq ([{source: "a", target: "b", topics: ["c"]}])}
  end

end