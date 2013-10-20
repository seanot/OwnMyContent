class Feed < ActiveRecord::Base
  belongs_to :user
  has_many :enclosures

  def server_path
    "#{self.user.server_path}/#{self.id}"
  end

  def client_path
    "#{self.user.client_path}/#{self.title}"
  end

end
