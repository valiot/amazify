class AddFacebookToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :id_facebook, :string
    add_column :users, :name, :string
  end
end
