# WebServer_C
基于Ruby on Rails 实现的国科大BBS网站

## 开发环境：
* 开发语言：`Ruby`
* 开发环境：`Ubuntu 20.04， ruby 2.7.0,  Rails 5.2.4.4`

## 功能说明：
* 用户
  * 登录
    * 密码登录
    * 邮箱验证登录（临时票据）
  * 注销（管理员可操作）
    * 清空用户学号、邮箱信息，转化为待激活状态
  * 查看所有用户（管理员可操作）
  * 查看个人信息
    * 姓名
    * 性别
    * 邮箱
    * 账户类型
    * 年级
    * 学号
    * 学院
    * 研究所
    * 博硕类型
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
rails generate model VideoReply  reply: references
-------------------------------------------

#创建TextBlog表
rails generate scaffold TextBlog title:string tag:string content:text response_count:integer click_count:integer accessment:integer user:references file_transfer:references
rails generate model TextReply  reply: references video_blog: references
-------------------------------------

# 创建Resource表
rails generate scaffold ResourceBlog title:string tag:string response_count:integer click_count:integer accessment:integer user:references file_transfer:references
rails generate model ResourceReply  reply: references

# 消息回复数据库
rails generate model Reply send_user_id:integer receive_user_id:integer content:string

# 学院数据库
rails generate model AcademyOrganization code_number:string academy_name:string organization_name:string 
rails generate model Project code_number:string project_name:string

#迁移
rails db:migrate
```
