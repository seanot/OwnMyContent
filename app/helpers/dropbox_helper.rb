module DropboxHelper

  def dbx_client
    @client ||= DropboxClient.new(current_user.oauth_token)
  end

  def upload_enclosure!(enc)
    enclosure_file = open(enc.client_path)
    uploader = DropboxboxClient::ChunkedUploader.new(dbx_client, enclosure_file, enc.size)
    uploader.upload
    msg = uploader.finish(enc.server_path)
  end

end
