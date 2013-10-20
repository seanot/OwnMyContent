require 'open-uri'

class FeedsController < ApplicationController

  def index

  end

  def new
    @feed = Feed.new
  end

# 'http://feeds.feedburner.com/eatthishotshow'
# http://feeds2.feedburner.com/talpodcast
  def create
    feed_info = current_user.feeds.create(feed_params)
    xml = open(feed_params[:url])
    feed = FeedzirraPodcast::Parser::Podcast.parse(xml)
    feed_info.update_attribute(:title, feed.title)

    @info = []
    feed.items.each do |i|
      url = i.enclosure.url
      feed_info.enclosures.create({url: url})
      @info << url
    end
    redirect_to feed_path(feed_info)
  end

  def show
    @feed = Feed.find(params[:id])
    @info = @feed.enclosures


    # When we start creating directories for user files,
    # uncomment this and change the filepath to the
    # path where we're staging files to send to dropbox

    # open("#{filepath}/directory.html", 'wb') do |f|
    #   f << (render_to_string :show)
    # end
  end

  def save_test
    upload_enclosure!(Feed.find(7).enclosures[3])
  end

  private
  def feed_params
    params.require(:feed).permit(:url)
  end

end
