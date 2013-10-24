class Directory < ActiveRecord::Base
  belongs_to :feed
  after_save :post_save

  def server_path
    p self
    p self.feed
    "#{self.feed.server_path}/directory.html"
  end

  def client_path
    "#{self.feed.client_path}/directory.html"
  end

  def make_server_directory!
    directory_name = self.feed.server_path
    FileUtils.mkdir_p(directory_name) unless File.exists?(directory_name)
  end

  def save_to_server!(html)
    make_server_directory!
    open(self.server_path, 'wb') do |f|
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
    UploadWorker.perform_async(self.id, 'directory')
  end

  def delete_from_server!
    File.delete(self.server_path)
  end

  # =================================
  # Upon Save
  # =================================

  def post_save
    if self.status_changed?
      if status == "Waiting to Upload"
        self.upload_to_dropbox!
      elsif status == "Complete"
        self.delete_from_server!
      end
    end
  end
end
