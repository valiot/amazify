class CreateAssistances < ActiveRecord::Migration[5.0]
  def change
    create_table :assistances do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.text :from

      t.timestamps
    end
  end
end
