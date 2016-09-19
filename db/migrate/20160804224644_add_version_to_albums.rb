class AddVersionToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :version, :string
  end
end
