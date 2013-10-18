Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :dropbox_oauth2, ENV['DROPBOX_APP_KEY'], ENV['DROPBOX_APP_SECRET']
end
