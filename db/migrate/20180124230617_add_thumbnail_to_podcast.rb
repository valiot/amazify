class AddThumbnailToPodcast < ActiveRecord::Migration[5.0]
  def change
    add_column :podcasts, :thumbnail, :string
  end
end
