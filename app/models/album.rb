class Album < ActiveRecord::Base
  VERSIONS = ["s", "l"]
  validates :band_id, :title, presence: true
  validates :version, presence: true, inclusion: VERSIONS
  belongs_to :band
  has_many :tracks, dependent: :destroy
end
