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
    sex = rand(1..2)==1 ? "男" : "女"
    activated=true
    User.create!(name: name ,user_number: user_number, email: email,sex: sex , password: password, password_confirmation: password,activated: activated)
end

99.times do |n|
    code_number_project = "#{"%02d"%(n)}"
    project_name= "#{n+152}专业"
    Project.create!(code_number: code_number_project, project_name: project_name)

    code_number_academy_organization = "#{50100+n}"

    organization_name = "#{n%10 + 342}研究所"
    academy_name = "#{n+675}学院"
    AcademyOrganization.create!(code_number: code_number_academy_organization, academy_name: academy_name, organization_name: organization_name)
end