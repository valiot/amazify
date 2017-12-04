class CreateUsersAssistances < ActiveRecord::Migration[5.0]
  def change
    create_table :users_assistances do |t|
      t.integer :id_user, limit: 4
      t.text :from

      t.timestamps
    end
  end
end
