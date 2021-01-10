# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'roo'

=begin
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
=end

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
Tag.create(name: "情感天地")

#generate video_blog
all_titles = ["不会傅里叶的程序员都应该看一下"，"把傅里叶变换讲得好清楚","一个傅里叶变化讲得很清楚的视频"]
all_content = ["自己看了好久都没懂，这个视频一次就明白了","一个深入浅出的小视频，看了很有收货","讲得很有道理，我一遍就理解了"]
all_reply = ["很棒！讲得很好","不错不错！","非常感谢！","看了这个视频收获很大"]

#20 blogs in each tag
20.times do |dummy|
    (1..4).each do |tag_id|
        user = User.order("RANDOM()").first
        all_tags = Tag.all.each{|x|x.id}
        video_blog = user.video_blogs.new
        video_blog.title = all_titles.sample
        video_blog.content = all_content.sample
        video_blog.user_id = user.id
        video_blog.response_count = 0
        video_blog.click_count = rand(20..30)
        video_blog.accessment = 0
        video_blog.file_path = ["test1.mp4","test2.mp4"].sample# 文件目录
        video_blog.tag_id = tag_id# 如果增加板块数目则要改动
        video_blog.save
    end
end

#generate video_reply
VideoBlog.all.each do |video_blog|
    20.times do |dumpy|
        user = User.order("RANDOM()").first
        video_blog.response_count += 1
        reply = Reply.new
        reply.send_user_id = user.id
        reply.receive_user_id = video_blog.user_id
        reply.content = all_reply.sample
        reply.save
        video_reply = video_blog.video_replys.new
        video_reply.reply_id = reply.id
        video_blog.save
    end
end

=begin
#generate video_blog
all_titles = ["震惊，程序员必看","惊了，看过的码农都说好","收获很大"]
all_content = ["一个深入浅出的小视频，看了很有收货","讲得很有道理我一遍就理解了"]



#generate text_blog
all_text_titles = ["夜深了，说个故事","分手要怎么办","今年成绩是满绩哈哈哈","求救！！！！！","招聘","说说今天发生的一件事，震惊我妈"]
all_text_content = ["爱你~","我是帅哥","故事是这样的"]
20.times do |dummy|
    (1..4).each do |tag_id|
        user = User.order("RANDOM()").first
        all_tags = Tag.all.each{|x|x.id}
        video_blog = user.video_blogs.new
        video_blog.title = all_titles.sample
        video_blog.content = all_content.sample
        video_blog.user_id = user.id
        video_blog.response_count = 0
        video_blog.click_count = 0
        video_blog.accessment = 0
        video_blog.file_path = ["test1.mp4","test2.mp4"].sample# 文件目录
        video_blog.tag_id = tag_id# 如果增加板块数目则要改动
        video_blog.save
    end
end
#generate video_reply
VideoBlog.all.each do |video_blog|
    20.times do |dumpy|
        user = User.order("RANDOM()").first
        video_blog.response_count += 1
        reply = Reply.new
        reply.send_user_id = user.id
        reply.receive_user_id = video_blog.user_id
        reply.content = ["很棒！","不错不错！","非常感谢！"].sample
        reply.save
        video_reply = video_blog.video_replys.new
        video_reply.reply_id = reply.id
        video_blog.save
    end
end 

20.times do |dummy|
    (1..4).each do |tag_id|
        user = User.order("RANDOM()").first
        all_tags = Tag.all.each{|x|x.id}   
        text_blog = user.text_blogs.new
        text_blog.title = all_text_titles.sample
        text_blog.content = all_text_content.sample
        text_blog.user_id = user.id
        text_blog.response_count = 0
        text_blog.click_count = 0
        text_blog.accessment = 0
        text_blog.tag_id = tag_id# 如果增加板块数目则要改动
        text_blog.save
    end
end

#generate text_reply
TextBlog.all.each do |text_blog|
    20.times do |dumpy|
        user = User.order("RANDOM()").first
        text_blog.response_count += 1
        reply = Reply.new
        reply.send_user_id = user.id
        reply.receive_user_id = text_blog.user_id
        reply.content = ["唉我也是","有酒吗","明白了"].sample
        reply.save
        text_reply = text_blog.text_replys.new
        text_reply.reply_id = reply.id
        text_blog.save
    end
end    

=end