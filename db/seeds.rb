# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(
  first_name: "Nate",
  last_name: "Welling",
  email: "nate@cheapeats.com",
  password: "12345678"
)

4.times do
  User.create!(
    first_name: Faker::Name.first_name, #=> "Kaci"
    last_name: Faker::Name.last_name, #=> "Ernser"
    email: Faker::Internet.email, #=> "kirsten.greenholt@corkeryfisher.info"
    password: "123"
  )
end
puts "Created #{User.count} users"

15.times do
  Listing.create!(
    user_id: Faker::Number.between(1, 5), #=> 7
    title: Faker::StarWars.character, #=> "Anakin Skywalker"
    about: Faker::Hipster.paragraph, #=> "Migas fingerstache pbr&b tofu. Polaroid distillery typewriter echo tofu actually. Slow-carb fanny pack pickled direct trade scenester mlkshk plaid. Banjo venmo chambray cold-pressed typewriter. Fap skateboard intelligentsia."
    property_type: ['Apartment', 'House', 'Bed & Breakfast'].sample,
    room_type: ['Entire home/apt', 'Private room', 'Shared room'].sample,
    bedrooms: Faker::Number.between(1, 4), #=> 7
    bathrooms: Faker::Number.between(1, 4), #=> 7
    guests: Faker::Number.between(1, 4), #=> 7
    price: Faker::Number.between(65, 199), #=> 7
    address: Faker::Address.street_address, #=> "282 Kevin Brook"
    city: Faker::Address.city, #=> "Imogeneborough"
    state: Faker::Address.state, #=> "California"
    zip: Faker::Address.zip, #=> "58517"
    country: Faker::Address.country, #=> "French Guiana"
    photos: [Faker::Avatar.image(Faker::Lorem.word, "500x500")]
  )
end
puts "Created #{Listing.count} listings"


first_date = Date.today

25.times do
  reservation = Reservation.create!(
    user_id: Faker::Number.between(1, 5), #=> 7
    listing_id: Faker::Number.between(1, 12), #=> 7
    start_date: Faker::Date.between(first_date, first_date + 2.days), # Random date between today & 2.days.from_today
    end_date: Faker::Date.between(first_date + 5.days, first_date + 10.days) # Random date between 5.days.from_today & 10.days.from_today
  )

  reservation.dates = (reservation.start_date..reservation.end_date).map(&:to_s)

  reservation.dates.each do |date|
    BookedDate.create!(reservation_id: reservation.id, listing_id: reservation.listing.id, date: date)
  end

  first_date = first_date + 2.weeks
end
puts "Created #{Reservation.count} reservations, with #{BookedDate.count} booked dates"

