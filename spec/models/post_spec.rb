require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:author) { FactoryBot.create(:user) }
  let(:liker) { FactoryBot.create(:user) }
  let(:other) { FactoryBot.create(:user) }

  context 'liking and unliking a post' do
    before(:each) do
      @post = described_class.create(author: author, body: "test")
      @like = FactoryBot.create(:like, user: liker, likeable: @post)
    end

    it 'liking increases the like count by 1' do
      expect(@post.likes_count).to eq(1)
    end

    it 'unliking decreases the like count by 1' do
      @like.destroy

      expect(@post.likes_count).to eq(0)
    end
  end

  context 'viewing posts index' do
    before(:each) do
      @post1 = described_class.create(author: author, body: "test1")
      @post2 = described_class.create(author: liker, body: "test2")
      @post3 = described_class.create(author: other, body: "test3")
      @posts = described_class.where(author_id: [author.id, liker.id, other.id])
      @friend_request = FactoryBot.create(:friend_request, sender: author, receiver: liker, accepted: true)

      @visible_posts = @posts.of_friends_and_user(author)
    end

    it 'can see posts posted by self and friends but not non-friends' do
      expect(@visible_posts).to contain_exactly(@post1, @post2)
    end
  end
end
