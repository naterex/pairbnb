class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.timestamps null: false
      t.integer :user_id
      t.string :title
      t.text :about
      t.integer :price
      t.string :property_type
      t.string :room_type
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :guests
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.json :photos
    end

    add_index :listings, :user_id
    add_index :listings, :title
    add_index :listings, :about
    add_index :listings, :price
    add_index :listings, :property_type
    add_index :listings, :room_type
    add_index :listings, :bedrooms
    add_index :listings, :bathrooms
    add_index :listings, :guests
    add_index :listings, :address
    add_index :listings, :city
    add_index :listings, :state
    add_index :listings, :country

  end
end
