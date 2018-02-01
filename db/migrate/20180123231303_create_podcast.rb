class CreatePodcast < ActiveRecord::Migration[5.0]
  def change
    create_table :podcasts do |t|
      t.integer :episode, index: true, unique: true
      t.string :title, index: true, unique: true
      t.string :slug, index: true, unique: true
      t.string :video_link, unique: true
      t.string :audio_link, unique: true
      t.string :image
      t.string :thumbnail
      t.text :text
      t.text :guests
      t.text :quote
      t.integer :reading_time, default: 30
      t.date :published
      t.integer :status, default: 0
      t.integer :tags, default: 0
      t.belongs_to :category, index: true, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.string :video_link
      t.string :audio_link
      t.string :image
      t.string :thumbnail
      t.text :text
      t.integer :reading_time, default: 30
      t.integer :status, default: 0
      t.integer :tags, default: 0
      t.belongs_to :category, index: true, foreign_key: true
      t.timestamps
    end
  end
end
