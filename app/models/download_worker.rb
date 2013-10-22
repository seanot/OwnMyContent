class DownloadWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def download_enclosure!(enc)
    open(enc.server_path, 'wb') do |f|
      f << full_file(enc.url)
    end
  end

  def full_file(path)
    open(path).read
  end

  def try_download(enc)
    enc.update_status("Downloading")
    begin
      download_enclosure!(enc)
      enc.update_status("Waiting to Upload")
    rescue Errno::ENOENT => e
      enc.update_status("File Error: #{e.to_s}")
    rescue Exception => e
      enc.update_status("Download Failed. Will retry.")
      puts e  # for troubleshooting. probably remove before we ship.
    end
  end

  def perform(enclosure_id)
    enc = Enclosure.find(enclosure_id)
    try_download(enc)
  end

end
