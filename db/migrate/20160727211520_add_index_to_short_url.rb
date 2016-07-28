class AddIndexToShortUrl < ActiveRecord::Migration
  def change
    add_index :shortened_urls, :short_url
    add_index :shortened_urls, :user_id
  end
end
