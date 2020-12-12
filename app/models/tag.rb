class Tag < ApplicationRecord
<<<<<<< HEAD
    has_many :video_blogs
    has_many :resource_blogs
    has_many :text_blogs

    def self.get_all_tags
        Tag.all.collect{|x| [x.name,x.id]}
    end
=======
>>>>>>> ab637d2b2f734b236864521c2de849ceebdaffad
end
