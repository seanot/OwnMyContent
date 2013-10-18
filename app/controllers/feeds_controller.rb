require 'open-uri'

class FeedsController < ApplicationController
  def index

  end

  def new
  end

# 'http://feeds.feedburner.com/eatthishotshow'
  def create
    p params[:url]
    xml= open(params[:url])
    feed = FeedzirraPodcast::Parser::Podcast.parse(xml)
    @info = []
    feed.items.each do |i|
      @info << i.enclosure_url
    end
    render :test_view
  end

end

# user_id
# rss_url
# fields_to_keep
