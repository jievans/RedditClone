require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :name, :password

  before_validation :generate_token, :on => :create

  include BCrypt

  def password=(password)
    self.password_digest = Password.create(password).to_s
  end

  def password_equals?(password)
    Password.new(self.password_digest).is_password?(password)
  end

  def change_token!
    self.token = SecureRandom.urlsafe_base64
    self.save!
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end
