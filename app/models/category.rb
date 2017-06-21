class Category < ActiveRecord::Base
  has_many :articles

  def slug
    name.parameterize
  end
end
