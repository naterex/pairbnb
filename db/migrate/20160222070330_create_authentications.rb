class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :user_id
      t.string :uid
      t.string :token
      t.string :provider
      t.timestamps null: false
    end

    add_index :authentications, :user_id
    add_index :authentications, :uid
    add_index :authentications, :token
    add_index :authentications, :provider

  end
end
