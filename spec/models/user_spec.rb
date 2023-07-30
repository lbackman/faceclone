require 'rails_helper'
require 'helpers/remove_uploaded_files'

RSpec.describe User, type: :model do
  prepend RemoveUploadedFiles
  it { is_expected.to validate_content_type_of(:avatar)
    .allowing('image/png', 'image/jpeg')
    .rejecting('text/plain', 'text/xml')
  }
  
  it { is_expected.to validate_dimensions_of(:avatar)
    .width_between(80..250)
    .height_between(80..250)
  }

  context "with a valid image file" do
    before(:each) do
      @user = create(:user)
    end

    it "jpg is attached" do
      @user.avatar.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'valid.jpg')),
        filename: 'valid.jpg',
        content_type: 'image/jpeg'
      )
      expect(@user.valid?).to be true
    end

    it "png is attached" do
      @user.avatar.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'valid.png')),
        filename: 'valid.png',
        content_type: 'image/png'
      )
      expect(@user.valid?).to be true
    end
  end

  context "with an invalid image file" do
    before(:each) do
      @user = create(:user)
    end

    it "with non-square aspect ratio is not attached" do
      @user.avatar.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'invalid_aspect_ratio.jpg')),
        filename: 'invalid_aspect_ratio.jpg',
        content_type: 'image/jpeg'
      )
      expect(@user.valid?).to be false
    end

    it "with too high resolution is not attached" do
      @user.avatar.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'invalid_resolution.jpg')),
        filename: 'invalid_resolution.jpg',
        content_type: 'image/jpeg'
      )
      expect(@user.valid?).to be false
    end

    it "with wrong image format is not attached" do
      @user.avatar.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'invalid_format.gif')),
        filename: 'invalid_format.gif',
        content_type: 'image/gif'
      )
      expect(@user.valid?).to be false
    end

    it "that is not an image at all is not attached" do
      @user.avatar.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'invalid_filetype.txt')),
        filename: 'invalid_filetype.txt',
        content_type: 'text/plain'
      )
      expect(@user.valid?).to be false
    end
  end
end
