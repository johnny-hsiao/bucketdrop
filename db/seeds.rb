require 'faker'

SUPERUSERS = [{
    first_name: "Johnny",
    last_name: "Hsiao",
    username: "admin",
    email: "johnny@example.com",
    password: "admin"
  },
  {
    first_name: "Trevor",
    last_name: "Guile",
    username: "trevor",
    email: "trevor@example.com",
    password: "admin"
  },
]

SUPERUSERS.size.times do |i|
  admin = User.create(
    first_name: SUPERUSERS[i][:first_name],
    last_name: SUPERUSERS[i][:last_name],
    username: SUPERUSERS[i][:username],
    email: SUPERUSERS[i][:email],
    password: SUPERUSERS[i][:password]
  )

  bucket = admin.buckets.create(name: "travel")


  5.times do
    item = Item.new(name: Faker::Address.country)
    item.user = admin
    bucket.items << item
  end

  bucket2 = admin.buckets.create(name: "see color")


  5.times do
    item = Item.new(name: Faker::Color.color_name)
    item.user = admin
    bucket2.items << item
  end

  bucket3 = admin.buckets.create(name: "visit universities")


  5.times do
    item = Item.new(name: Faker::University.name)
    item.user = admin
    bucket3.items << item
  end
end