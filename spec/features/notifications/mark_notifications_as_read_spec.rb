require 'rails_helper'

RSpec.describe 'Mark notifications as read', type: :system do

  before do
    @sender_1 = FactoryBot.create(:user)
    @sender_2 = FactoryBot.create(:user)
    @receiver = FactoryBot.create(:user)
    FactoryBot.create(:friend_request, sender: @sender_1, receiver: @receiver)
    FactoryBot.create(:friend_request, sender: @sender_2, receiver: @receiver)
    FactoryBot.create(:friend_request, sender: @sender_1, receiver: @sender_2)
    login_as(@receiver)
  end

  context 'visiting root page' do
    it 'does not mark notifications as read' do
      @read_count = @receiver.notifications.count(:read_at)
      expect(@read_count).to eq(0)
    end
  end

  context 'visting user page:' do
    it 'own page does not mark notifications as read' do
      visit user_path(@receiver)

      @read_count = @receiver.notifications.count(:read_at)
      expect(@read_count).to eq(0)
    end

    it 'of a sender will mark notification as read' do
      visit user_path(@sender_1)

      @read_count = @receiver.notifications.count(:read_at)
      expect(@read_count).to eq(1)
    end

    it 'of another user does not affect their notifications' do
      other_user_read_before = @sender_2.notifications.count(:read_at)

      visit user_path(@sender_2)
      other_user_read_after = @sender_2.notifications.count(:read_at)
      expect(other_user_read_before).to eq(other_user_read_after)
    end
  end

  context 'visiting users index' do
    it 'will mark both as read' do
      visit users_path

      @read_count = @receiver.notifications.count(:read_at)
      expect(@read_count).to eq(2)
    end

    it 'does not affect notifications of others' do
      other_user_read_before = @sender_2.notifications.count(:read_at)

      visit users_path
      other_user_read_after = @sender_2.notifications.count(:read_at)
      expect(other_user_read_before).to eq(other_user_read_after)
    end
  end
end
