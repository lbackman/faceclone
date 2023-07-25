class PostsController < ApplicationController
  before_action :set_post, only: %i[ edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post
      .of_friends_and_user(current_user)
      .order(created_at: :desc)
      .with_author_information
  end

  # GET users/1/posts/1 or users/1/posts/1.json
  def show
    @user = User.find(params[:user_id])
    if current_user == @user || current_user.friends_with?(@user)
      @post = Post.includes(comments: [author: [:user_information, avatar_attachment: :blob]]).find(params[:id])
    else
      render_access_denied
    end
  end

  # GET users/1/posts/new
  def new
    @post = Post.new
  end

  # GET users/1/posts/1/edit
  def edit
  end

  # POST users/1/posts or users/1/posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html do
          redirect_back fallback_location: user_post_url(current_user, @post),
          notice: "Post was successfully created."
        end
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT users/1/posts/1 or users/1/posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to user_post_url(current_user, @post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE users/1/posts/1 or users/1/posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:body, :author_id)
    end
end
