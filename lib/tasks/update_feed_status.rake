namespace :feed do

  desc "Update feed status based on enclosure statuses"
  task status_update: :environment do

    Feed.active.each do |f|
      total_completed  = 0
      total_incomplete = 0
      total_enclosures = f.enclosures.count
      f.enclosures.each do |e|
        if e.
        p "total enclosures: #{total_enclosures}"
      end
    end
  end

end
