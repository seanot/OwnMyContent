class Enclosure < ActiveRecord::Base
  belongs_to :feed

  require 'open-uri'
  require 'mp3info'
  require 'fileutils'

  METADATA_FIELDS = [
        :media_type, :title, :artist, :album,
        :year, :comm, :tcom, :tcon, :tcop,
        :tit2, :tit3, :tcat, :trck, :tyer,
        :tgid, :wfed]

  # def self.download_feed(info)
  #   info.each do |i|
  #     @filename = i.url
  #     extract_metadata(@filename)
  #     save_file
  #   end
  # end

  # def extract_metadata(file)
  #   @file = open(file).read
  #   Mp3Info.open(@file) do |mp3|
  #     @title = mp3.tag.title
  #     @artist = mp3.tag.artist
  #     @album = mp3.tag.album
  #     @year = mp3.tag.year
  #     @comm = mp3.tag2.comm
  #     @tcom = mp3.tag2.tcom
  #     @tcon = mp3.tag2.tcon
  #     @tcop = mp3.tag2.tcop
  #     @tit2 = mp3.tag2.tit2
  #     @tit3 = mp3.tag2.tit3
  #     @tcat = mp3.tag2.tcat
  #     @trck = mp3.tag2.trck
  #     @tyer = mp3.tag2.tyer
  #     @tgid = mp3.tag2.tgid
  #     @wfed = mp3.tag2.wfed
  #   end
  # end

  # def create_enclosure_entry
  #   enc = Enclosure.new(
  #                       media_type: 'mp3',
  #                       title: @title,
  #                       artist: @artist,
  #                       album: @album,
  #                       year: @year,
  #                       comm: @comm,
  #                       tcom: @tcom,
  #                       tcon: @tcon,
  #                       tcop: @tcop,
  #                       tit2: @tit2,
  #                       tit3: @tit3,
  #                       tcat: @tcat,
  #                       trck: @trck,
  #                       tyer: @tyer,
  #                       tgid: @tgid,
  #                       wfed: @wfed
  #                       )
  #   if enc.save
  #     # notice: 'temporary message database entry successful'
  #   else
  #     # error: 'temporary message database entry failed'
  #   end
  # end

  # def save_file
  #   open("#{self.server_path}/#{@filename}", 'wb') do |f|
  #      f << open(@file).read
  #   end
  # end

  def metadata
    info = {}
    METADATA_FIELDS.each do |field|
      info[field] = self[field] if self[field]
    end
    info
  end


  def save_to_server
    directory_name = ("#{self.feed.server_path}")
    FileUtils.mkdir_p(directory_name) unless File.exists?(directory_name)
    open("#{directory_name}/#{self.id}", 'wb') do |f|
       f << open("#{self.url}").read
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
