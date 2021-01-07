# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'roo'

# 初始化Users
99.times do |n|
    name  = Faker::Name.name
    num = "%03d"%(n+1)
    user_number="#{rand(2019..2022)}#{rand(1..2)}#{rand(80100..80200)}#{'%02d'%rand(1..60)}#{num}"
    email = "test_#{n+1}@eamil.com"
    password = "passwords"
    sex = rand(1..2)==1 ? "男" : "女"
    activated=true
    User.create!(name: name ,user_number: user_number, email: email,sex: sex , password: password, password_confirmation: password,activated: activated)
end

User.create!(name: "余甜" ,user_number: "202028015059033", email: "a_flying_fish@outlook.com",sex: "男" , password: "123456789", password_confirmation: "123456789",activated: true, admin: true)

# 初始化学院
xlsx = Roo::Excelx.new(File.expand_path('./db/school_info/academy_organization.xlsx'))

xlsx.each_row_streaming(offset: 1) do |row|
    AcademyOrganization.find_or_create_by(code_number: row[0].value, organization_name: row[1].value)
end

# 初始化专业
xlsx = Roo::Excelx.new(File.expand_path('./db/school_info/project.xlsx'))

xlsx.each_row_streaming(offset: 1) do |row|
    Project.find_or_create_by(code_number: row[0].value, project_name: row[1].value)
end


#genetare Tag
Tag.create(name: "数学")
Tag.create(name: "计算机")
Tag.create(name: "日常生活")
