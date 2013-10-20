module DropboxHelper

  def dbx_client
    @client ||= DropboxClient.new(current_user.oauth_token)
  end

  def upload_enclosure!(enc)
    enclosure_file = open(enc.server_path)
    uploader = DropboxClient::ChunkedUploader.new(dbx_client, enclosure_file, enc.size)
    begin_upload(enc)
    send_file(uploader)
    finish_upload(enc, uploader)
  end

  def begin_upload(enc)
    enc.update_attribute(:upload_status, 'started')
  end

  def send_file(uploader)
    uploader.upload
  end

  def finish_upload(enc, uploader)
    metadata = uploader.finish(enc.client_path)
    # enc.update_attribute(:client_path, metadata["path"])
    enc.update_attribute(:upload_status, "complete")
  end

end
