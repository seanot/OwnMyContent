require 'open-uri'

class FeedsController < ApplicationController
  include SessionsHelper

  def index

  end

  def new
    @feed = Feed.new
  end

# 'http://feeds.feedburner.com/eatthishotshow'
  def create
    feed_info = current_user.feeds.create(feed_params)
    xml = open(feed_params[:url])
    feed = FeedzirraPodcast::Parser::Podcast.parse(xml)
    @info = []
    feed.items.each do |i|
      url = i.enclosure.url
      feed_info.enclosures.create({url: url})
      @info << url
    end
    render :test_view
  end

  private
  def feed_params
    params.require(:feed).permit(:url)
  end

end
