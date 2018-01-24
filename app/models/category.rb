class Category < ApplicationRecord
  has_many :articles
  has_many :podcasts
  before_create :set_slug
  before_update :set_slug

  def set_slug
    self.slug = name.parameterize
  end
end
