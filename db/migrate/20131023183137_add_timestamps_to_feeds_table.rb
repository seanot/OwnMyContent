class AddTimestampsToFeedsTable < ActiveRecord::Migration
  def change
    add_column :feeds, :created_at, :datetime
    add_column :feeds, :updated_at, :datetime
  end
end
