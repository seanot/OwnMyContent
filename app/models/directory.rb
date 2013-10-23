class Directory < ActiveRecord::Base
  belongs_to :feed
  after_save :post_save

  def server_path
    "#{self.feed.path}/directory.html"
  end

  def client_path
    "#{self.feed.client_path}/directory.html"
  end

  def save_to_server!(html)
    open(self.path, 'wb') do |f|
      f << (html)
    end
  end

  def update_status(msg)
    self.update_attribute(:status, msg)
  end


  # =================================
  # Upload utilities
  # =================================
  def size
    File.new(self.server_path).size
  end

  def user
    self.feed.user
  end

  def upload_to_dropbox!
    UploadWorker.perform_async(self.id)
  end

  def delete_from_server!
    File.delete(self.server_path)
  end

  # =================================
  # Upon Save
  # =================================

  def post_save
    if self.status_changed?
      if upload_status == "Waiting to Upload"
        self.upload_to_dropbox!
      elsif upload_status == "Complete"
        self.delete_from_server!
      end
    end
  end
end
