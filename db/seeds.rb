# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
99.times do |n|
    name  = Faker::Name.name
    num = "%03d"%(n+1)
    user_number="#{rand(2019..2022)}#{rand(1..2)}#{rand(50149..50152)}#{rand(55..60)}#{num}"
    email = "test_#{n+1}@eamil.com"
    password = "password"
    User.create!(name: name ,user_number: user_number, email: email, password: password, password_confirmation: password)
end