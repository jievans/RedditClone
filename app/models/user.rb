require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :name, :password

  before_validation :generate_token, :on => :create

  has_many :subs,
  :class_name => "Sub",
  :foreign_key => :moderator_id,
  :primary_key => :id

  has_many :links,
  :class_name => "Link",
  :foreign_key => :user_id,
  :primary_key => :id

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
