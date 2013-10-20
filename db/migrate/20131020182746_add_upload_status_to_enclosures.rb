class AddUploadStatusToEnclosures < ActiveRecord::Migration
  def change
    add_column :enclosures, :upload_status, :string
  end
end
