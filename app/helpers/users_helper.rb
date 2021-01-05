module UsersHelper
    def gravatar_image(user, options = { size: 80 })
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.name, class: "gravatar img-circle")
    end
end

module ActivateType
    BackToHome=0
    UserInformation=1
    UpdateInformation=2
    MyVideosBlog=3
    MyTextBlogs=4
    MyResourceBlogs=5
    ShowUsers=6
end

# 注册网址 https://en.gravatar.com/