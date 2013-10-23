namespace :feed do

  desc "Update feed status based on enclosure statuses"
  task status_update: :environment do

    Feed.active.each do |f|
      total_enclosures = f.enclosures.count ||= 0
      if total_enclosures >= 0
        total_completed  = f.enclosures.complete.count ||= 0
        total_incomplete = total_enclosures - total_completed
        percent_complete = total_completed/total_enclosures
        puts "Feed #{f.title} is #{percent_complete}% complete"
      end
      puts "#{f.title} is an feempty feed"
    end
  end

end
