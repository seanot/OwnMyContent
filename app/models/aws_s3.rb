class UploadAWS

  require 'yaml'
  include AWS::S3

  AWS_CONFIG = YAML::load(File.open("#{Rails.root}/config/aws_s3.yml"))
  ASSIGNED_BUCKET = AWS_CONFIG['bucket']

  def self.establish_connection
    Base.establish_connection!(
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'])
  end

  def self.set_default_host
    DEFAULT_HOST.replace AWS_CONFIG['default_host']
  end

  def self.save_to_bucket(file)
    S3Object.store(file, open(file), ASSIGNED_BUCKET)
  end

  def self.delete_from_bucket(file)
    S3Object.delete(file, ASSIGNED_BUCKET)
  end

end