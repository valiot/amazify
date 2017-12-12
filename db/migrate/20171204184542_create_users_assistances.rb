class CreateUsersAssistances < ActiveRecord::Migration[5.0]
  def change
    create_table :users_assistances do |t|
      t.belongs_to :users, index: true
      t.text :from

      t.timestamps
    end
  end
end
