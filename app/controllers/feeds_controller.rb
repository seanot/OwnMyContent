require 'open-uri'

class FeedsController < ApplicationController
  def index

  end

  def new
  end
# 'http://feeds.feedburner.com/eatthishotshow'
  def create
    p params[:url]
    @feed = open(params[:url]).read
    render :test_view
  end

end

# user_id
# rss_url
# fields_to_keep
