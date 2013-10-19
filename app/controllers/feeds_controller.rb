require 'open-uri'

class FeedsController < ApplicationController
  def index

  end

  def new
    @feed = Feed.new
  end

# 'http://feeds.feedburner.com/eatthishotshow'
  def create
    xml = open(feed_params[:url])
    feed = FeedzirraPodcast::Parser::Podcast.parse(xml)
    @info = []
    feed.items.each do |i|
      @info << i.enclosure.url
    end
    render :test_view
  end

  private
  def feed_params
    params.require(:feed).permit(:url)
  end

end
