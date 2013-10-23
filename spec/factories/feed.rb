FactoryGirl.define do
  factory :feed do |f|
    f.user_id 5
    f.title "my podcast"
    f.url "www.podcast.com/feed"
  end

end