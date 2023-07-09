require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:liker) { FactoryBot.create(:user) }
  let(:author) { FactoryBot.create(:user) }
  let(:likeable) { FactoryBot.create(:post, author: author) }

  context "Can't like a thing more than once" do
    before(:each) do
      @like1 = described_class.create(user_id: liker.id, likeable_id: likeable.id, likeable_type: "Post")
      @like2 = described_class.new(user_id: liker.id, likeable_id: likeable.id, likeable_type: "Post")
    end

    it "can like a likeable thing" do
      expect(@like1).to be_valid
    end

    it "can't like something twice" do
      expect(@like2).to_not be_valid
    end
  end
end
