require 'rails_helper'

RSpec.describe 'Sending a friend request', type: :system do

  before do
    sender = FactoryBot.create(:user)
    receiver = FactoryBot.create(:user)
    login_as(sender)
    visit user_path(receiver)
  end

  it 'friend request button exists' do
    expect(page).to have_content('Add Friend')
  end

  it 'clicking the button sends request' do
    click_on 'Add Friend'

    expect(page).to have_content("Remove Friend Request")
  end
end
