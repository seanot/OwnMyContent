module DropboxHelper

  def dbx_client
    @client ||= DropboxClient.new(current_user.oauth_token)
  end

  def upload_enclosure!(enc)
    msg = dbx_client.put_file(enc.client_path, enc.server_path)
    puts msg
  end

end
