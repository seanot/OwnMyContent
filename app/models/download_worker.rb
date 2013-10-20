class DownloadWorker
  include Sidekiq::Worker

  def download_enclosure!(enc)
    open(enc.server_path, 'wb') do |f|
       f << open("#{enc.url}").read
    end
  end

  def update_status!(enc)
    enc.update_attribute(:upload_status, "pending")
  end

  def perform(enclosure_id)
    download_enclosure!(Enclosure.find(enclosure_id))
  end

end
