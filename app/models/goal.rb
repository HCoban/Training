# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  gstatus    :string           not null
#  completed  :boolean          default(FALSE), not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Goal < ActiveRecord::Base
  validates :name, :gstatus, :completed, :user, presence: true
  validates :gstatus, inclusion: { in: %w(private public) }

  after_initialize :ensure_defaults

  belongs_to :user

  def ensure_defaults
    self.completed ||= false
    self.gstatus ||= "private"
  end
end
