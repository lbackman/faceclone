require 'rails_helper'

RSpec.describe 'Likes index for a post', type: :system do

  before do
    @post_author = FactoryBot.create(:user)
    @post_liker = FactoryBot.create(:user)
    FactoryBot.create(:friend_request, sender: @post_author, receiver: @post_liker, accepted: true)
    @post = FactoryBot.create(:post, author: @post_author, body: "Test post")
    login_as(@post_liker)
    visit user_path(@post_author)
  end

  it 'the likes index is empty if no likes yet' do
    visit post_likes_path(@post)
    expect(page).to_not have_content(@post_liker.full_name)
  end

  it 'liking a post will add the liker to the likes index' do
    find('button.post.like').click

    visit post_likes_path(@post)
    expect(page).to have_content(@post_liker.full_name)
  end

  it 'unliking the post will again remove the liker from the index' do
    find('button.post.like').click
    sleep(0.1)
    find('button.post.like').click

    visit post_likes_path(@post)
    expect(page).to_not have_content(@post_liker.full_name)
  end
end
