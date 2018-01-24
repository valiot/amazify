class CreatePodcast < ActiveRecord::Migration[5.0]
  def change
    create_table :podcasts do |t|
      t.integer :episode, index: true, unique: true
      t.string :video_link
      t.string :audio_link
      t.string :image
      t.text :text
      t.integer :tags
      t.belongs_to :category, index: true, foreign_key: true

      t.timestamps
    end
  end
end