require 'open-uri'
require 'mp3info'

class FeedsController < ApplicationController

  def index
    @feed = Feed.new
  end

  def new
    @feed = Feed.new
  end

  def create
    feed = current_user.feeds.find_by(feed_params)
    if feed
      feed.parse_feed!
    else
      feed = current_user.feeds.find_or_create_by(feed_params)
    end
    redirect_to feed_path(feed)
  end

  def show
    @feed = Feed.find(params[:id])
    @enclosures = @feed.enclosures


    # When we start creating directories for user files,
    # uncomment this and change the filepath to the
    # path where we're staging files to send to dropbox

    # open("#{filepath}/directory.html", 'wb') do |f|
    #   f << (render_to_string :show)
    # end
  end

  def save_test

  end

  private
  def feed_params
    params.require(:feed).permit(:url)
  end

end
