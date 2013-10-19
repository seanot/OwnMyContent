class Upload

  def self.content_saver

    content = File.open("ouput_file.txt", 'w') do |file|
      file.write (entries)
    end
  end
end