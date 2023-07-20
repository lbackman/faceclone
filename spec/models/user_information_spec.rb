require 'rails_helper'

RSpec.describe UserInformation, type: :model do
  let(:user) { FactoryBot.create(:user) }
  it "when a field is left empty, it does not update to an empty string" do
    user.user_information.update(hometown: "")

    expect(user.hometown).to be_nil
  end

  it "when a field is filled in it updates to that value" do
    user.user_information.update(about_me: "I like pizza")

    expect(user.about_me).to eq("I like pizza")
  end
end
