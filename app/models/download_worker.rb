class DownloadWorker
  include Sidekiq::Worker

  def download_enclosure!(enc)
    open(enc.server_path, 'wb') do |f|
       f << open(enc.url).read
    end
  end

  def begun_status(enc)
    enc.update_attribute(:upload_status, "staging file")
  end

  def finished_status(enc)
    enc.update_attribute(:upload_status, "pending")
  end

  def perform(enclosure_id)
    enclosure = Enclosure.find(enclosure_id)
    begun_status(enclosure)
    download_enclosure!(enclosure)
    finished_status(enclosure)
  end

end
