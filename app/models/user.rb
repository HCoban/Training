class User < ActiveRecord::Base
  validates :email, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true

  after_initialize :ensure_session_token

  def self.generate_session_token
    SecureRandom.urlsafe_base64(32)
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.is_password?(password)
    encry = BCrypt::Password.create(password)
    BCrypt.Password.new(encry).is_password?(self.password_digest)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email, password: password)
    return nil if user.nil
    user.valid? ? user : nil
  end
end
