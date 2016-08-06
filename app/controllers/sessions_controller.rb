class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(session_params[:username], session_params[:password])

    if @user
      login!(@user)
      redirect_to @user
    else
      flash.now[:errors] = ["Incorrect login info"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private
  def session_params
    params.require(:session).permit(:username, :password)

  end
end
