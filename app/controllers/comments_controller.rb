class CommentsController < ApplicationController
  before_action :require_logged_in, only: [:new, :create, :edit, :update]

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to @comment.post
    else
      flash[:errors] = @comment.errors.full_messages
      @post = Post.find(comment_params[:post_id])
      redirect_to @post
    end
  end

  def upvote
    @vote = Vote.new(user_id: current_user.id,
                     value: 1,
                     votable_id: params[:id],
                     votable_type: "Comment")
    @vote.save
    flash[:errors] = @vote.errors.full_messages unless @vote.save
    redirect_to :back
  end

  def downvote
    @vote = Vote.new(user_id: current_user.id,
                     value: -1,
                     votable_id: params[:id],
                     votable_type: "Comment")
    @vote.save
    flash[:errors] = @vote.errors.full_messages unless @vote.save
    redirect_to :back
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
