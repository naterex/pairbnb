class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :user_id
      t.string :uid
      t.string :token
      t.string :provider
      t.timestamps null: false
    end
  end
end
