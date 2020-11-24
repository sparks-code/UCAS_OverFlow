class User < ApplicationRecord
    # 开启安全密码验证
    has_secure_password

    has_many :video_blogs
    has_many :file_blogs
    has_many :resource_blog

    validates :password, confirmation: true, presence: true, allow_nil: true
 
    validates :name, presence: true, length: { minimum: 2, maximum: 50 }
    validates :user_number, uniqueness: true, presence: true, format:{with: /\A(\d|x){15}\z/i, message: "student id (:user number) is not Invalid"}
    validates :email, presence: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Email Format Invalid"}, uniqueness: { case_sensitive: false }
    validates :sex, presence: true, format: {with: /\A(男|女){1}\z/, message: "sex should be sure"}, allow_nil: true

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

    def TranslateAdmin
        if self.admin?
            return "是"
        else
            return "否"
        end
    end

    def TranslateGrade
        return self.grade+"级"
    end

    def TranslateType
        if self.type=="1"
            return "博士"
        elsif self.type=="2"
            return "硕士"
        else
            return nil
        end
    end

    def TranslateAcademy
        # 根据机构转译
        return nil
    end

    def TranslateOrganization
        return self.organization
    end

    def TranslateProject
        return self.project
    end
end
