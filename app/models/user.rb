# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :password, length: { minimum: 8, allow_nil: true }
  validates :username, presence: true, uniqueness: true
  validates :password_digest, :session_token, presence: true

  attr_reader :password

  after_initialize :ensure_session_token

  has_many :subs,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :Sub

  has_many :posts,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Post

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user
      BCrypt::Password.new(user.password_digest).is_password?(password)
    end
    user
  end

  private
  def generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end
end
