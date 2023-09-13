require 'rails_helper'

RSpec.describe 'Search users', type: :system do

  def verify_users(on_page: [], not_on_page: [])
    on_page.map(&:full_name).all? { |name| expect(page).to have_content(name) } &&
    not_on_page.map(&:full_name).all? { |name| expect(page).to_not have_content(name) }
  end

  before do
    @alice = FactoryBot.create(:user)
    alice_info = FactoryBot.create(:user_information, user: @alice, first_name: "Alice", last_name: "Allison")
    @allison = FactoryBot.create(:user)
    allison_info = FactoryBot.create(:user_information, user: @allison, first_name: "Allison", last_name: "Agro")
    @bob = FactoryBot.create(:user)
    @bob_info = FactoryBot.create(:user_information, user: @bob, first_name: "Bob", last_name: "Allman")
    FactoryBot.create(:friend_request, sender: @alice, receiver: @bob, accepted: true)
    login_as(@alice)
    visit users_path
  end

  context 'in users index' do
    it 'before searching, all users are on the page' do
      verify_users(on_page: [@alice, @allison, @bob])
    end

    it 'all names matching fully or partially with the search term are visible' do
      fill_in('search', with: 'lli')
      click_button('Search')
      sleep(0.1)

      verify_users(on_page: [@alice, @allison], not_on_page: [@bob])
    end

    it 'search is case insensitve' do
      fill_in('search', with: 'lLI')
      click_button('Search')
      sleep(0.1)

      verify_users(on_page: [@alice, @allison], not_on_page: [@bob])
    end

    it 'searching for a full name returns at least the user with that name' do
      fill_in('search', with: 'bob allman')
      click_button('Search')
      sleep(0.1)

      verify_users(on_page: [@bob], not_on_page: [@alice, @allison])
    end

    it 'the order of the search terms does not matter' do
      fill_in('search', with: 'allman bob')
      click_button('Search')
      sleep(0.1)

      verify_users(on_page: [@bob], not_on_page: [@alice, @allison])
    end

    it 'too many search terms yields no results' do
      fill_in('search', with: 'bob alice agro')
      click_button('Search')
      sleep(0.1)

      verify_users(not_on_page: [@alice, @allison, @bob])
    end
  end

  context 'on user\'s friends page' do
    it 'the user whose user page it is not visible' do
      visit friends_user_path(@alice)

      verify_users(on_page: [@bob], not_on_page: [@alice, @allison])
    end

    it 'cannot search among non-friends' do
      visit friends_user_path(@alice)
      fill_in('search', with: 'allison')
      click_button('Search')
      sleep(0.1)

      verify_users(not_on_page: [@alice, @allison, @bob])
    end
  end
end
