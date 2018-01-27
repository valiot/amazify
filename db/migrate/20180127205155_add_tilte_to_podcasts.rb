class AddTilteToPodcasts < ActiveRecord::Migration[5.0]
  def change
    add_column :podcasts, :title, :string
  end
end
