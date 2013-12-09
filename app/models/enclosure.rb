class Enclosure < ActiveRecord::Base
  belongs_to :feed
  validates :url, presence: true

  require 'open-uri'
  require 'mp3info'
  require 'fileutils'


  after_create :save_to_server!
  after_save :post_save

  METADATA_FIELDS = [
        :media_type, :title, :artist, :album,
        :year, :comm, :tcom, :tcon, :tcop,
        :tit2, :tit3, :tcat, :trck, :tyer,
        :tgid, :wfed]

  def server_path
    "#{self.feed.server_path}/#{self.id}"
  end

  def file_name
    self.url.split('/').last
  end

  def client_path
    "#{self.feed.client_path}/#{self.file_name}"
  end

  def metadata
    info = {}
    METADATA_FIELDS.each do |field|
      info[field] = self[field] if self[field]
    end
    info
  end

  def update_status(msg)
    self.update_attribute(:upload_status, msg)
  end

  # =======================================
  # Download utilities
  # =====================================
  def extract_metadata!
    unless self.title
      Mp3Info.open(self.server_path) do |mp3|
        self.title = mp3.tag.title
        self.artist = mp3.tag.artist
        self.album = mp3.tag.album
        self.year = mp3.tag.year
        self.comm = mp3.tag2.comm
        self.tcom = mp3.tag2.tcom
        self.tcon = mp3.tag2.tcon
        self.tcop = mp3.tag2.tcop
        self.tit2 = mp3.tag2.tit2
        self.tit3 = mp3.tag2.tit3
        self.tcat = mp3.tag2.tcat
        self.trck = mp3.tag2.trck
        self.tyer = mp3.tag2.tyer
        self.tgid = mp3.tag2.tgid
        self.wfed = mp3.tag2.wfed
      end

      self.title = "Untitled" unless self.title

      self.save
    end
  end

  # def make_server_directory!
  #   directory_name = self.feed.server_path
  #   FileUtils.mkdir_p(directory_name) unless File.exists?(directory_name)
  # end

  def save_to_server!
    DownloadWorker.perform_async(self.id)
  end


  # ==================
  # Class methods
  # ===================


  def self.complete
    # return all completed enclosures
    Enclosure.where(upload_status: "Complete")
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
    UploadWorker.perform_async(self.id, 'enclosure')
  end

  def delete_from_server!
    File.delete(self.server_path)
  end

  # =================================
  # Upon Save
  # =================================

  def post_save
    if self.upload_status_changed?
      if upload_status == "Waiting to Upload"
        self.upload_to_dropbox!
      elsif upload_status == "Uploading"
        self.extract_metadata!
      elsif upload_status == "Complete"
        self.delete_from_server!
      end
    end
  end

end
