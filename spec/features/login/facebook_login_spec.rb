require 'rails_helper'

RSpec.describe 'Log in with Facebook', type: :system do

  after(:each) do
    OmniAuth.config.mock_auth[:facebook] = nil
  end
  before do 
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    visit root_path
  end

  it 'user can log in with facebook with valid credentials' do
    find('button', exact_text: 'Sign in with Facebook').click

    expect(page).to have_content("Log Out")
  end

  it 'user cannot log in with invalid credentials' do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    silence_omniauth { find('button', exact_text: 'Sign in with Facebook').click }

    expect(page).to have_content("Sign in with Facebook") #redirect to root upon failure
  end
end

# See https://stackoverflow.com/questions/19483367/rails-omniauth-error-in-rspec-output
def silence_omniauth
  previous_logger = OmniAuth.config.logger
  OmniAuth.config.logger = Logger.new("/dev/null")
  yield
ensure
  OmniAuth.config.logger = previous_logger
end
