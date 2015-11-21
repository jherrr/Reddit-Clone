class User < ActiveRecord::Base
  attr_reader :password
  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true
  before_validation :ensure_session_token

  has_many :posts,
    foreign_key: :author_id,
    class_name: "Post", dependent: :destroy

  has_many :subs,
    foreign_key: :moderator_id,
    class_name: "Sub", dependent: :destroy

  def self.find_by_credential(email, password)
    user = User.find_by(email: email)
    if user.is_password?(password)
      user
    else
      nil
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end


end
