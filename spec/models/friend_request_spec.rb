require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  # Unnecessary tests: https://www.codewithjason.com/examples-pointless-rspec-tests/
  # Thus commented out
  # describe "Associations" do
  #   it { should belong_to(:sender) }
  #   it { should belong_to(:receiver) }
  # end

  describe "Validations" do
    let(:sender)     { create(:user) }
    let(:receiver)   { create(:user) }
    let(:third_user) { create(:user) }

    context "Sender and receiver are not the same" do
      it "is invalid when sender and receiver are the same" do
        request = described_class.new(sender_id: sender.id, receiver_id: sender.id)
        expect(request).not_to be_valid
      end

      it "is valid when sender and receiver are different" do
        request = described_class.new(sender_id: sender.id, receiver_id: receiver.id)
        expect(request).to be_valid
      end
    end

    context "Can't send multiple requests between same two users" do
      before(:each) do
        first = described_class.create(sender_id: sender.id, receiver_id: receiver.id)
      end

      it "sender can't send a new request" do
        second = described_class.new(sender_id: sender.id, receiver_id: receiver.id)
        expect(second).not_to be_valid
      end

      it "receiver can't send a new request to original sender" do
        second = described_class.new(sender_id: receiver.id, receiver_id: sender.id)
        expect(second).not_to be_valid
      end

      it "but can send to another user" do
        third = described_class.new(sender_id: receiver.id, receiver_id: third_user.id)
        expect(third).to be_valid
      end
    end
  end
end
