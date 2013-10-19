class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to new_feed_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

end
