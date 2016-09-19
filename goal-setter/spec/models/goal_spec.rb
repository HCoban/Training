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

require 'rails_helper'

RSpec.describe Goal, type: :model do

  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:user)}
  it {should validate_presence_of(:completed)}
  it {should validate_presence_of(:gstatus)}
  it {should belong_to(:user)}
  # it {should have_many(:comments)}

  describe "handles defaults" do
    it "assigns default if not given" do
      a = Goal.new(name: "Loose weight", user_id: 1)
      expect(a.gstatus).to eq("private")
      expect(a.completed).to eq(false)
    end

    it "handles variables if given" do
      a = Goal.new(name: "Loose weight", user_id: 1, gstatus: "public", completed: "true")
      expect(a.gstatus).to eq("public")
      expect(a.completed).to eq(true)
    end
  end
end
