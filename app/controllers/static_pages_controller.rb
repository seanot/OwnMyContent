class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def select
    p current_user
    if current_user
      @all_feeds=[]
      @active_feeds=[]
      # check for current user
      # needs to render all feeds for current user
      @active_feeds << Feed.find_by(user_id: current_user.id, status: "active")
    else
      redirect_to :root
    end
  end
end
