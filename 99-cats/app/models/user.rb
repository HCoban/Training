class User < ActiveRecord::Base

  has_many :cats,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Cat

  validates :user_name, :session_token, :password_digest, presence: true
  validates :user_name, :session_token, uniqueness: true
  after_initialize :ensure_token

  attr_reader :password

  def ensure_token
    self.session_token ||= SecureRandom::urlsafe_base64(32)
  end

  def reset_session_token!
    session[session_token] = SecureRandom::urlsafe_base64(32)
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    pass = BCrypt::Password.new(self.password_digest)
    pass.is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    @user = User.find_by(user_name: user_name)
    return nil unless @user
    @user.is_password?(password) ? @user : nil
  end
end
