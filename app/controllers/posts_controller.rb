class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :show, :update, :destroy, :upvote, :downvote]
  before_action :require_logged_in, only: [:new, :create, :edit, :update]


  def upvote
    @vote = Vote.new(user_id: current_user.id,
                     value: 1,
                     votable_id: params[:id],
                     votable_type: "Post")
    flash[:errors] = @vote.errors.full_messages unless @vote.save
    redirect_to :back
  end

  def downvote
    @vote = Vote.new(user_id: current_user.id,
                     value: -1,
                     votable_id: params[:id],
                     votable_type: "Post")
    @vote.save
    flash[:errors] = @vote.errors.full_messages unless @vote.save
    redirect_to :back
  end

  def show
    @all_comments = @post.comments_by_parent_id
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to @post
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end

  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end


  def destroy
    @post.destroy
    redirect_to subs_url
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
