class AddImagesCountToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :images_count, :integer
  end
end
