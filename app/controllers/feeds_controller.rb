require 'open-uri'
require 'mp3info'

class FeedsController < ApplicationController

  def index

  end

  def new
    @feed = Feed.new
  end

  def create
    feed_info = current_user.feeds.create(feed_params)
    xml = open(feed_params[:url])
    feed = FeedzirraPodcast::Parser::Podcast.parse(xml)
    feed_info.update_attribute(:title, feed.title)

    feed.items.each do |i|
      url = i.enclosure.url
      # file = open(url).read if url
      feed_info.enclosures.create({ url: url}) if url
    end

    feed_info.download_enclosures!

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

  end

  private
  def feed_params
    params.require(:feed).permit(:url)
  end

end
