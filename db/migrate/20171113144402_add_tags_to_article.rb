class AddTagsToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :tags, :integer
  end
end
