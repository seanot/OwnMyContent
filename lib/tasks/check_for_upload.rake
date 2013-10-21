namespace :enc do

  desc "Check for uploads waiting"
  @enc_need_update=[]
  task check: :environment do
    @enc_need_update << Enclosure.find_by(upload_status: 'waiting to retry')
    @enc_need_update.each do |enclosure|
         if enclosure.upload_status == 'waiting to retry'
            enclosure.upload_to_dropbox!
         end
    end
  end

  task test: :environment do
    print "happy joy joy"
  end

end
