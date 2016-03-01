class CreateBookedDates < ActiveRecord::Migration
  def change
    create_table :booked_dates do |t|
      t.integer :reservation_id
      t.integer :listing_id
      t.date :date
      t.timestamps null: false
    end

    add_index :booked_dates, :reservation_id
    add_index :booked_dates, :listing_id
    add_index :booked_dates, :date
  end
end
