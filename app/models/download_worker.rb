class DownloadWorker
  include Sidekiq::Worker

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
    rescue Exception => e # This catches any uncaught errors.
      enc.update_status("Download Failed. Will retry.")
      raise "Retry: Download Failed"
    end
  end

  def perform(enclosure_id)
    begin
    enc = Enclosure.find(enclosure_id)
      unless enc.upload_status =~ /File Error*/
        try_download(enc)
      end
    rescue ActiveRecord::RecordNotFound
      raise "Retry: PG Error"
    end
  end

end
