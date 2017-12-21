class User < ActiveRecord::Base
  has_secure_password
  has_many :articles
  has_many :assistances
  validates_uniqueness_of :email
  validates_uniqueness_of :id_facebook
  enum role: [:user, :admin]
end
