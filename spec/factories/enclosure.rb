FactoryGirl.define do
  factory :enclosure do
    feed
    media_type "mp3"
    url "http://services.gpb.org/sites/feed_episode.mp3"
    title "Today's Podcast"
    artist "Sean"
    album "Example"
    year "2013"
  end
end
