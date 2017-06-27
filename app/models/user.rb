class User < ActiveRecord::Base
  has_secure_password
  has_many :articles
  validates_uniqueness_of :email
  enum role: [:user, :admin]
end
