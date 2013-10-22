RSpec.configure do |config|
  config.include Features::UserHelpers, type: :feature
  config.include Features::FeedHelpers, type: :feature
  config.include Features::EnclosureHelpers, type: :feature
end