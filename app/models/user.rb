class User < ApplicationRecord
    # 开启安全密码验证
    has_secure_password

    has_many :video_blogs
    has_many :file_blogs
    has_many :text_blogs
    has_many :resource_blog

    validates :password, confirmation: true, presence: true, allow_nil: true
 
    validates :name, presence: true, length: { minimum: 2, maximum: 50 }
    validates :user_number, uniqueness: true, presence: true, format:{with: /\A(\d|x){15}\z/i, message: "student id (:user number) is not Invalid"}
    validates :email, presence: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Email Format Invalid"}, uniqueness: { case_sensitive: false }
    validates :new_email, presence: true, allow_nil: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Email Format Invalid"}, uniqueness: { case_sensitive: false }
    validates :sex, presence: true, format: {with: /\A(男|女){1}\z/, message: "sex should be sure"}, allow_nil: true

    attr_accessor :remember_token, :activation_token

      # 激活邮件回调
    before_create :create_activation_token
    before_save :downcase_email                 # 邮箱存储小写

    # 计算年级
    def grade
        return self.user_number[0..3]
    end

    # 计算博硕类型
    def type
        return self.user_number[4]
    end

    # 计算培养单位代码
    def organization
        return self.user_number[5..9]
    end

    # 计算专业代码
    def project
        return self.user_number[10..11]
    end

    def translate_admin
        if self.admin?
            return "是"
        else
            return "否"
        end
    end

    def translate_grade
        return self.grade+"级"
    end

    def translate_type
        if self.type=="1"
            return "博士"
        elsif self.type=="2"
            return "硕士"
        else
            return nil
        end
    end

    def translate_academy
        if AcademyOrganization.find_by(:code_number=>self.organization)
            return AcademyOrganization.find_by(:code_number=>self.organization).academy_name
        else
            return self.organization
        end
    end

    def translate_organization
        if AcademyOrganization.find_by(:code_number=>self.organization)
            return AcademyOrganization.find_by(:code_number=>self.organization).organization_name
        else
            return self.organization
        end
    end

    def translate_project
        if Project.find_by(:code_number=>self.project)
            return Project.find_by(:code_number=>self.project).project_name
        else
            return self.project
        end 
    end

    # 计算用户的访问令牌, 存至数据库
    def remember_user
        self.remember_token = User.create_new_token
        self.update_attribute(:remember_digest, User.calculate_hash(remember_token))
    end

    # 清空用户访问令牌
    def forget_user
        self.update_attribute(:remember_digest,nil)
    end

    # 核对用户提供的访问令牌是否有效
    def authenticated?(attribute, token)
        database_key_name = self.send("#{attribute}_digest")
        if database_key_name.nil?
          return false 
        end
        BCrypt::Password.new(database_key_name).is_password?(token)
    end

    def create_activation_token
        self.activation_token = User.create_new_token
        self.activation_digest = User.calculate_hash(self.activation_token)
    end

    # 邮箱字母转化为小写
    def downcase_email
        self.email = self.email.downcase
    end

    def is_effective?
        if self.activated
            return true
        else
            return false
        end
    end

    class << self
        # 返回提供参数 string 的散列摘要值
        def calculate_hash(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end

        # 返回一个22位长的随机字符串
        def create_new_token
            SecureRandom.urlsafe_base64
        end
    end
end
