require 'rails_helper'

RSpec.describe 'Likes index for a comment', type: :system do

  before do
    @post_author = FactoryBot.create(:user)
    @post_liker = FactoryBot.create(:user)
    @comment_author = FactoryBot.create(:user)
    @comment_liker = FactoryBot.create(:user)
    FactoryBot.create(:friend_request, sender: @post_author, receiver: @post_liker, accepted: true)
    FactoryBot.create(:friend_request, sender: @post_author, receiver: @comment_author, accepted: true)
    FactoryBot.create(:friend_request, sender: @post_author, receiver: @comment_liker, accepted: true)
    @post = FactoryBot.create(:post, author: @post_author, body: "Test post")
    @comment = FactoryBot.create(:comment, author: @comment_author, commentable: @post, body: "Test comment")
    login_as(@post_liker)
    visit user_path(@post_author)
    find('button.post.like').click
    logout(@post_liker)
    sleep 0.1
    login_as(@comment_liker)
    visit user_path(@post_author)
  end

  it 'the post liker does not show up in the comment likes index' do
    visit comment_likes_path(@post, @comment)
    expect(page).to_not have_content(@post_liker.full_name)
  end

  it 'the comment likes index is empty if no likes yet' do
    visit comment_likes_path(@post, @comment)
    expect(page).to_not have_content(@comment_liker.full_name)
  end

  it 'liking a post will add the liker to the likes index' do
    find('button.comment.like').click

    visit comment_likes_path(@post, @comment)
    expect(page).to have_content(@comment_liker.full_name)
  end

  it 'unliking the post will again remove the liker from the index' do
    find('button.comment.like').click
    sleep(0.1)
    find('button.comment.like').click

    visit post_likes_path(@post)
    expect(page).to_not have_content(@comment_liker.full_name)
  end
end
