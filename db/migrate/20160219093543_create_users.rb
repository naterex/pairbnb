class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps null: false
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :encrypted_password, limit: 128
      t.string :confirmation_token, limit: 128
      t.string :remember_token, limit: 128, null: false
    end

    add_index :users, :first_name
    add_index :users, :last_name
    add_index :users, :email
    add_index :users, :remember_token
  end
end
