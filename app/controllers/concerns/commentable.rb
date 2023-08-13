module Commentable
  extend ActiveSupport::Concern
  include ActionView::RecordIdentifier
  include RecordHelper
  
  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.author = current_user
    
    respond_to do |format|
      if @comment.save
        comment = Comment.new
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id_for_records(@commentable, comment), partial: 'comments/form', locals: { commentable: @commentable, comment: comment }) }
        format.html { render partial: 'comments/form', locals: { commentable: @commentable, comment: comment }}
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id_for_records(@commentable, @comment), partial: 'comments/form', locals: { commentable: @commentable, comment: @comment }) }
        format.html { render partial: 'comments/form', locals: { commentable: @commentable, comment: @comment }}
      end
    # redirect_back(fallback_location: @commentable)
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end
end
