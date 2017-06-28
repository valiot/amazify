class AddIndexToArticle < ActiveRecord::Migration
  def change
    add_index :articles, :link, unique: true
  end
end
