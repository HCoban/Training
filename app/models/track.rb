class Track < ActiveRecord::Base
  validates :album_id, :title, presence: :true

  belongs_to :album
  belongs_to :band,
    through: :album
    source: :band
end
