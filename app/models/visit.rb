class Visit < ActiveRecord::Base
  belongs_to(
  :visitors,
  class_name: :User,
  foreign_key: :user_id,
  primary_key: :id
  )

  belongs_to(
  :visited_urls,
  class_name: :ShortenedURL,
  foreign_key: :short_url_id,
  primary_key: :id
  )

  def self.record_visit!(user, shortened_url)
    short_url = ShortenedURL.find_by(short_url: shortened_url)
    Visit.create!(user_id: user.id, short_url_id: short_url.id)
  end
end
