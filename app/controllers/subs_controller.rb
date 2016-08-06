class SubsController < ApplicationController
  before_action :find_sub, only: [:edit, :update, :show, :destroy]
  before_action :require_logged_in, only: [:new, :create, :edit, :update]

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user
    if @sub.save
      redirect_to @sub
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @sub.update(sub_params)
      redirect_to @sub
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end


  def show
  end

  def index
    @subs = Sub.all
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description, :moderator)
  end

  def find_sub
    @sub = Sub.find(params[:id])
  end
end
