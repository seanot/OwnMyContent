class Feed < ActiveRecord::Base
  belongs_to :user
  has_many :enclosures

  after_create :parse_feed!
  after_create :status_fresh

  def status_fresh
    self.status = "fresh"
    self.save
  end


  # ==================
  # Class methods
  # ===================
  def self.active
    # return all active feeds
    Feed.where(status: "active")
  end

  def self.complete
    # return all completed feeds
    Feed.where(status: "complete")
  end

  def self.fresh
    # return all feeds that are new
    Feed.where(status: "fresh")
  end

  # ==================
  # Instance Methods
  # ===================
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

  def download_enclosures!
    self.enclosures.each do |enc|
      enc.save_to_server
    end
  end

  # ==================
  # Upon creation
  # ===================
  def xml
    @feed ||= FeedzirraPodcast::Parser::Podcast.parse(open(self.url))
  end

  def parse_feed!
    self.update_attribute(:title, xml.title)
    xml.items.each do |item|
      url = item.enclosure.url
      self.enclosures.create({url: url}) if url
    end
  end

end


