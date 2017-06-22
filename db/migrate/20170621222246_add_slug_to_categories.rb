class AddSlugToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :slug, :string
    add_index :categories, :slug
    Category.all.each do |category|
      category.update_column(:slug, category.name.parameterize)
    end
  end
end
