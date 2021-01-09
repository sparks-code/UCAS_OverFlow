module StaticPagesHelper
    

    def gravatar_image_for_exist_user(user, options = { size: 80 })
        if user != nil
            gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
            size = options[:size]
            gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
            image_tag(gravatar_url, alt: user.name, class: "gravatar img-circle")
        else
            image_tag('no_user_img.png', class: "gravatar img-circle user_head")
        end
    end
end
