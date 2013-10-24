namespace :feed do

  desc "Update feed status based on enclosure statuses"
  task status_update: :environment do
      Feed.all.each do |f|
    # Feed.active.each do |f|
      total_enclosures = f.enclosures.count ||= 0
      if total_enclosures > 0
        total_completed  = f.enclosures.complete.count ||= 0
        total_incomplete = total_enclosures - total_completed
        percent_complete = (total_completed.to_f/total_enclosures)*100
        p total_enclosures
        p total_completed
        p total_incomplete
        p percent_complete
        puts "Feed #{f.title} is #{percent_complete}% complete"
        f.percent_complete = percent_complete

      else
      f.status = "empty"
      puts "#{f.title} is an empty feed"
      end
            f.save

    end
  end
end
