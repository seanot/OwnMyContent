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

end
