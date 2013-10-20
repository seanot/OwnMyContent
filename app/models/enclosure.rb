class Enclosure < ActiveRecord::Base
  belongs_to :feed


require 'open-uri'

  def download_file
    open('public/test-file.mp3', 'wb') do |f|
       f << open('http://eatthishotshow.com/audio/eths134.mp3').read
    end
  end

  def server_path
    "#{self.feed.server_path}/#{self.id}"
  end

  def file_name
    self.url.split('/').last
  end

  def client_path
    "#{self.feed.client_path}/#{self.file_name}"
  end

end
