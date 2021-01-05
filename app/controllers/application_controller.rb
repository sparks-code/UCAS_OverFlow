class ApplicationController < ActionController::Base

    def hello
        render html: "测试主页"
    end
end
