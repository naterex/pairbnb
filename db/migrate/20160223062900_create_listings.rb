class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.timestamps null: false
      t.integer :user_id
      t.string :title
      t.text :about
      t.string :room_type
      t.string :property_type
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :guests
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
    end

    add_index :listings, :city
    add_index :listings, :state
    add_index :listings, :country
  end
end
