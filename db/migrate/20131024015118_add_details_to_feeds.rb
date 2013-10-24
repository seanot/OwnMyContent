class AddDetailsToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :percent_complete, :integer
  end
end
