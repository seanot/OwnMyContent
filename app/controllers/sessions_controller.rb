class SessionsController < ApplicationController
  def new
  end

  # sign in
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end
  # def create
  #   @user = User.find_by(email: params[:email])

  #   if @user && @user.authenticate(params[:password])
  #     session[:user_id] = @user.id
  #     redirect_to @user
  #   else
  #     @error = "Incorrect email or password"
  #     render :new
  #   end
  # end

  def destroy
    session[:user_id] = nil
    redirect_to :root 
  end



end
