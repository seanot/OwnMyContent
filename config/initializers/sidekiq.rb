Sidekiq.configure_server do |config|
  ActiveRecord::Base.configurations['development']['pool'] = 9
  ActiveRecord::Base.configurations['production']['pool'] = 9
end
