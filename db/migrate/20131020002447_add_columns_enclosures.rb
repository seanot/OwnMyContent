class AddColumnsEnclosures < ActiveRecord::Migration
  def change
    add_column :enclosures, :title, :string
    add_column :enclosures, :artist, :string
    add_column :enclosures, :album, :string
    add_column :enclosures, :year, :string
    add_column :enclosures, :comm, :text
    add_column :enclosures, :tcom, :string
    add_column :enclosures, :tcon, :string
    add_column :enclosures, :tcop, :string
    add_column :enclosures, :tit2, :text
    add_column :enclosures, :tit3, :text
    add_column :enclosures, :tcat, :string
    add_column :enclosures, :trck, :string
    add_column :enclosures, :tyer, :string
    add_column :enclosures, :tgid, :string
    add_column :enclosures, :wfed, :string
    add_column :enclosures, :created_at, :datetime
    add_column :enclosures, :updated_at, :datetime
  end
end
