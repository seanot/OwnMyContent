class CreateDirectories < ActiveRecord::Migration
  def change
    create_table :directories do |t|
      t.integer :feed_id
      t.string :status

      t.timestamps
    end
  end
end
