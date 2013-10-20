class Enclosure < ActiveRecord::Base
  belongs_to :feed

  def server_path
    "#{self.feed.server_path}/#{self.id}"
  end

  def file_name
    self.url.split('/').last
  end

  def client_path
    "#{self.feed.client_path}/#{self.file_name}"
  end

  def size
    File.new(self.server_path).size
  end

  def upload_to_dropbox!
    UploadWorker.perform_async(self.id)
  end

  def user
    self.feed.user
  end

  def upload?
    self.upload_status == 'pending' || self.upload_status == 'waiting to retry'
  end

end
