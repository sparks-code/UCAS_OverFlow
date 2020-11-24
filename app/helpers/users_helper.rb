module UsersHelper
    def GravatarImage(user)
        hash_value = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{hash_value}"

        image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end
end

# 注册网址 https://en.gravatar.com/