# WebServer_C
基于Ruby on Rails 实现的国科大BBS网站

## 开发环境：
* 开发语言：`Ruby`
* 开发环境：`Ubuntu 20.04， ruby 2.7.0,  Rails 5.2.4.4 bootstrap vue.js`

## 功能说明：
* 用户
  * 注册
    * 额外要求邮箱验证
  * 登录
    * 密码登录
    * 邮箱验证登录（临时票据）
  * 注销（管理员可操作）
    * 清空用户学号、邮箱信息，转化为待激活状态
  * 查看所有用户（管理员可操作）
  * 查看个人信息
    * 头像
    * 姓名
    * 性别
    * 邮箱
    * 账户类型
    * 年级
    * 学号
    * 学院
    * 研究所
    * 博硕类型
  * 查看我的视频、博客、资源
    * 标题（可跳转）
    * 点击数
    * 回复数
    * 日期
    * 删除

  * 信息修改
    * 邮箱包含额外验证（未验证状态不起作用）
  * 提升管理员权限
  * 自动信息生成（根据学号拉取年级、学号、学院、研究所、博硕类型）

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

# Users:db 添加remember_token
rails generate migration add_rememer_digest_to_users password_digest:string  

# 新建Session控制器
rails generate controller Sessions new

# 生成测试数据库
rails db:seed

# 重置数据库
rails db:migrate:reset

#修改合并videoBlog和FileTransfer
rails destroy FileTransfer

rails generate migration add_file_path_to_video_blogs file_path:string

rails generate migration remove_file_transfer_id_from_video_blogs file_transfer_id:integer

# 邮箱激活
rails generate mailer UserMailer account_activation

# 新建AccountActivations控制器
rails generate controller AccountActivations edit

# 新建
rails generate migration add_activation_token_to_users activation_token:string  

rails generate migration add_activation_digest_to_users activation_digest:string  

rails generate migration add_activated_to_users activated:boolean

rails generate migration add_activated_at_to_users activated_at:datetime

# 邮箱配置开发环境
\config\environments\development.rb

邮箱:
ucas_overflow@163.com
授权码：HENHZASQIBQZWXJI

# 加入新邮箱
rails generate migration add_new_email_to_users new_email:string

rails generate migration remove_activation_token_from_users activation_token:string 

rails generate migration add_login_token_to_users login_token:string  
rails generate migration remove_login_token_from_users login_token:string 
rails generate migration add_login_digest_to_users login_digest:string  

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