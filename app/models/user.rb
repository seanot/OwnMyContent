class User < ActiveRecord::Base
  has_many :feeds

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      # user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def server_path
    # "public/user_content/#{self.id}"
    "tmp/user_content/#{self.id}"
  end

  def client_path
    "Own-Your-Stuff"
  end



end
