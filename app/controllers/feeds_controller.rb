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
    @feed = Feed.new
  end

  def create
    feed = current_user.feeds.create(feed_params)
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
