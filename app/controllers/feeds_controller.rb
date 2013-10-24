require 'open-uri'
require 'mp3info'

class FeedsController < ApplicationController

  def index
    if current_user
      @feed = Feed.new
    else
      redirect_to :root
    end
  end

  def new
     if current_user
      @feed = Feed.new
    else
      redirect_to :root
    end
  end

  def create
    feed = current_user.feeds.find_by(feed_params)
    if feed
      feed.parse_feed!
    else
      feed = current_user.feeds.create(feed_params)
    end
    redirect_to feed_path(feed)
  end

  def show
    # if it's not your feed, don't show it and go to users feeds page instead
    @feed = Feed.find(params[:id])
    @enclosures = @feed.enclosures.paginate(:page => params[:page], :per_page => 30)

    if current_user && @feed.user_id == current_user.id
      @enclosures = @feed.enclosures
    else
      redirect_to :feeds
    end
  end

  def local_directory
    @feed = Feed.includes(:enclosures).find(params[:id])
    @enclosures = @feed.enclosures
    directory = @feed.directories.create
    directory.save_to_server!(render_to_string :directory, layout: 'local')
    directory.update_attribute(:status, "Waiting to Upload")
    render :directory
  end

  private
  def feed_params
    params.require(:feed).permit(:url)
  end

end
