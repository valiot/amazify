class AddUserToArticle < ActiveRecord::Migration
  def change
    add_reference :articles, :user, index: true, foreign_key: true

    Article.all.each do |article|
      article.update_column(:user_id, 2)
    end
  end
end
