class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def select
    @feeds=[]
    # check for current user
    # needs to render all feeds for current user
    @feeds << Feed.find_by(user_id: current_user.id)
  end
end
