class Feed < ActiveRecord::Base
  belongs_to :user
  has_many :enclosures


  def server_path
    "#{self.user.server_path}/#{self.id}"
  end

  def client_path
    "#{self.user.client_path}/#{self.title}"
  end

  def upload_to_dropbox!
    self.enclosures.each do |enc|
      enc.upload_to_dropbox! if enc.upload?
    end
  end

end
