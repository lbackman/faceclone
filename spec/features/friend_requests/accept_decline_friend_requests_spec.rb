require 'rails_helper'

RSpec.describe 'Accepting and declining a friend request', type: :system do
  before(:each) do
    @sender = FactoryBot.create(:user)
    @receiver = FactoryBot.create(:user)
    login_as(@sender)
    visit user_path(@receiver)
    click_on 'Add Friend'
    logout(@sender)
    sleep(0.1) # to properly logout the previous user this is needed
    login_as(@receiver)
    visit user_path(@sender)
  end

  it 'can accept friend request' do
    expect(page).to have_content('Accept Friend Request')
  end

  it 'clicking accept adds friend' do
    click_on 'Accept Friend Request'

    expect(page).to have_content('Unfriend')
  end

  it 'can decline friend request' do
    expect(page).to have_content('Decline Friend Request')
  end

  it 'clicking decline removes friend request' do
    click_on 'Decline Friend Request'

    expect(page).to have_content('Add Friend')
  end
end
