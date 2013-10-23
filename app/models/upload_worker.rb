class UploadWorker
  include Sidekiq::Worker

  def dbx_client(user)
    @client ||= DropboxClient.new(user.oauth_token)
  end

  def begin_upload(enc)
    enc.update_status('Uploading')
  end

  def send_file(uploader)
    uploader.upload
  end

  def finish_upload(enc, uploader)
    begin
      metadata = uploader.finish(enc.client_path)
      enc.update_status("Complete")

    rescue ActiveRecord::ConnectionTimeoutError
      enc.update_status("Upload failed. Will retry")
      raise "Retry: ActiveRecord Error"
    end
  end

  def upload_enclosure!(enc)
    enclosure_file = open(enc.server_path)
    uploader = DropboxClient::ChunkedUploader.new(dbx_client(enc.user), enclosure_file, enc.size)
    begin_upload(enc)
    send_file(uploader)
    finish_upload(enc, uploader)
  end

  def perform(enclosure_id)
    begin
      enc = Enclosure.find(enclosure_id)
      upload_enclosure!(enc)
    rescue Net::HTTPServiceUnavailable
      enc.update_status("Upload failed. Will retry")
      raise "Retry: DBX Connection failed"
    rescue Exception => e # This catches any other errors, so the status will get updated
      enc.update_status("Upload failed. Will retry.")
      raise "Retry: Other error: #{e}"
    end
  end

end
