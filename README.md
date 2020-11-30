# WebServer_C
基于Ruby on Rails 实现的国科大BBS网站

## 开发环境：
* 开发语言：`Ruby`
* 开发环境：`Ubuntu 20.04， ruby 2.7.0,  Rails 5.2.4.4`

## 环境复现
```Bash
# 创建users表
rails generate scaffold User name:string user_number:string email:string password:string sex:string admin:boolean 
# 开启密码验证
rails generate migration add_password_digest_to_users password_digest:string              

-----------------------------------
# 创建FileTransfer表
rails generate scaffold FileTransfer file_path:string introduction:string

# 创建Video表
rails generate scaffold VideoBlog title:string tag:string response_count:integer click_count:integer accessment:integer user:references file_transfer:references 
rails generate model VideoReply  reply:references
-------------------------------------------

#创建TextBlog表
rails generate scaffold TextBlog title:string tag:string content:text response_count:integer click_count:integer accessment:integer user:references file_transfer:references
rails generate model TextReply  reply:references
-------------------------------------

# 创建Resource表
rails generate scaffold ResourceBlog title:string tag:string response_count:integer click_count:integer accessment:integer user:references file_transfer:references
rails generate model ResourceReply  reply:references

# 消息回复数据库
rails generate model Reply send_user_id:integer receive_user_id:integer content:string

# 学院数据库
rails generate model AcademyOrganization code_number:string academy_name:string organization_name:string 
rails generate model Project code_number:string project_name:string

#迁移
rails db:migrate

#数据库改动1
修改合并videoBlog和FileTransfer
rails destroy FileTransfer
rails generate migration add_file_path_to_video_blogs file_path:string
rails generate migration remove_file_transfer_id_from_video_blogs file_transfer_id:integer

#数据库修改3
修改resourceBlog
rails generate migration add_file_path_to_resource_blogs file_path:string
rails generate migration remove_file_transfer_id_from_resource_blogs file_transfer_id:integer

#数据库修改3
新增tag库
rails generate model Tag name:string
移除tag字段并添加外键
rails generate migration remove_tag_from_video_blogs tag:string
rails generate migration remove_tag_from_resource_blogs tag:string

rails generate migration add_tag_ref_to_video_blog tag:references
rails generate migration add_tag_ref_to_resource_blog tag:references

#修改回复
rails destroy model VideoReply
rails destroy model TextReply
rails destroy model ResourceReply

rails generate model VideoReply  reply:references video_blog:references
rails generate model TextReply  reply:references text_blog:references
rails generate model ResourceReply  reply:references resource_blog:references

rails generate controller VideoReplys new edit
```
