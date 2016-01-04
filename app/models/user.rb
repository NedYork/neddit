class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :username, uniqueness: true

  after_initialize :ensure_session_token

  has_many(
   :moderated_subs,
   class_name: "Sub",
   foreign_key: :moderator_id
  )

  has_many(
    :authored_posts,
    class_name: "Post",
    foreign_key: :author_id
    )
    
  has_many :comments

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    (user && user.is_password?(password)) ? user : nil
  end

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

end
