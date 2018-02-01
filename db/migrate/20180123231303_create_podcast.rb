class CreatePodcast < ActiveRecord::Migration[5.0]
  def change
    create_table :podcasts do |t|
      t.integer :episode, index: true, unique: true
      t.string :title
      t.string :video_link
      t.string :audio_link
      t.string :image
      t.string :thumbnail
      t.text :text
      t.integer :reading_time, default: 30
      t.integer :status, default: 0
      t.integer :tags, default: 0
      t.belongs_to :category, index: true, foreign_key: true
      t.belongs_to :user

      t.timestamps
    end
  end
end