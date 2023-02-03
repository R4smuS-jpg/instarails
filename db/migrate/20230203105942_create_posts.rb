class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :content, null: true

      t.timestamps
    end

    add_reference :posts, :users, foreign_key: true
  end
end
