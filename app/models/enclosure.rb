class Enclosure < ActiveRecord::Base
  belongs_to :feed


require 'open-uri'

  def download_file
    open('public/test-file.mp3', 'wb') do |f|
       f << open('http://eatthishotshow.com/audio/eths134.mp3').read
    end
  end


end
