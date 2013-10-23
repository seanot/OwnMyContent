class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def select
    if current_user
      @active   = Feed.active
      @fresh    = Feed.fresh
      @complete = Feed.complete
    else
      redirect_to :root
    end
  end
end
