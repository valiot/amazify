class Category < ActiveRecord::Base
  has_many :articles
  before_create :set_slug
  before_update :set_slug

  def set_slug
    self.slug = name.parameterize
  end
end
