module Features
  module FeedHelpers

    def enter_rss_feed
      within('#feed_url') do
        fill_in 'Rss feed ', with: 'http://www.podcast.com/feed'
        click_button 'submit'
      end
    end
  end
end