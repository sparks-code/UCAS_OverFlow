module SessionsHelper
    #  记住用户，建立cookie
    def remember_user(user)
        user.remember_user  # 存储散列值
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    # 忘记用户, 删除cookie
    def forget_user(user)
        if user
            user.forget_user
        end
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    # 返回当前系统登录用户, 失败返回nil
    def current_user
        unless @current_user.nil?
            return @current_user
        end
        
        # 通过session恢复用户
        unless session[:user_id].nil?
            @current_user ||= User.find_by(id: session[:user_id].to_i)
            return @current_user
        end

        # 通过cookie恢复用户
        unless cookies[:user_id].nil?
            user_c = User.find_by(:id=>cookies.signed[:user_id].to_i)
            unless user_c.nil?
                if user_c.authenticated?(:remember,cookies[:remember_token])
                    @current_user = user_c
                    login_in(user_c)
                    return @current_user
                end
            end
        end

        @current_user = nil
        return @current_user
    end

    # 对指定用户做登录操作，建立session
    def login_in(user)
        if !user.activated
            redirect_to activate_url(:activate_id=>user.id)
            return false
        end
        session[:user_id] = user.id
        return true
    end

    # 对当前用户做登出操作，删除session
    def login_out
        self.forget_user(self.current_user)
        session.delete(:user_id)
        @current_user = nil
    end
    #********* end *********#

    # 返回当前是否存在已登录用户
    def logged_in?
        !self.current_user.nil?
    end

    # 存储转向地址
    def store_forwarding_url
        session[:forwarding_url] = request.original_url if request.get?
    end

    # 转向登录前页面
    def redirect_back_by_default(default_url)
        temp = session[:forwarding_url]
        session.delete(:forwarding_url)
        unless temp.nil?
            redirect_to temp
        else 
            redirect_to default_url
        end  
    end
end
