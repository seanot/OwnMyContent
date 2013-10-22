FactoryGirl.define do
  factory :user do |f|
    f.provider 'dropbox_oauth2'
    f.email 'name@name.com'
    f.uid 123545
    f.name 'Sean'
    f.oauth_token 'thisisanoauthtoken888'
    f.oauth_expires_at nil
  end
end