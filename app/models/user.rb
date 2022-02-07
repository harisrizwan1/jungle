class User < ActiveRecord::Base

  has_secure_password

  before_validation :downcase_email

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: {minimum: 6}

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    user && user.authenticate(password)
  end

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end

end
