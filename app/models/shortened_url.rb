class ShortenedURL < ActiveRecord::Base
  belongs_to(
  :submitter,
  class_name: :User,
  foreign_key: :user_id,
  primary_key: :id
  )

  has_many(
    :visits,
    class_name: :Visit,
    foreign_key: :short_url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    Proc.new { distinct }, #<<<
    through: :visits,
    source: :visitors
  )

  def self.random_code
    var = nil
    until var
      string = SecureRandom::urlsafe_base64
      var = string unless ShortenedURL.exists?(short_url: string)
    end
    var
  end

  def self.create_for_user_and_long_url!(user, long_url)
      ShortenedURL.create!(user_id: user.id,short_url: self.random_code, long_url: long_url)
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visits.select(:user_id).distinct.count
  end

  def num_recent_uniques
    visits.select(:user_id).distinct.where("created_at > '#{30.minutes.ago}'").count
  end
end
