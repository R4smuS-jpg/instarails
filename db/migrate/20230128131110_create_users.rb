class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    enable_extension "citext"

    create_table :users do |t|
      t.citext :email, null: false
      t.string :nickname, null: false
      t.string :full_name, null: false
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true, name: 'unique_emails' 
    add_index :users, :nickname, unique: true, name: 'unique_nicknames'
  end
end
