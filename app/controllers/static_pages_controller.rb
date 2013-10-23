class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def select
    if current_user
      @active   = Feed.where(user_id: current_user.id).active
      @fresh    = Feed.where(user_id: current_user.id).fresh
      @complete = Feed.where(user_id: current_user.id).complete
    else
      redirect_to :root
    end
  end
end
