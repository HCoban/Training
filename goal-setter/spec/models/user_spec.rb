# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  password_digest :string
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryGirl.create(:user)}

  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:password_digest)}
  it {should validate_presence_of(:session_token)}
  it {should have_many(:goals)}
  it {should have_many(:comments)}

  context "find_by_credentials" do
    before(:each) do
      user
    end
    it 'returns the user with valid parameters' do
      expect(User.find_by_credentials("Halil", "password123")).to eq(user)
    end

    it 'returns nil with invalid parameters' do
      expect(User.find_by_credentials("Halil", "password321")).to be(nil)
    end
  end

end#describe
