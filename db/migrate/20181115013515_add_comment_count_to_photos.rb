class AddCommentCountToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :comments_count, :integer
  end
end
