class AddTagIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :tag, foreign_key: true
  end
end
