class Photo < ActiveRecord::Base
    belongs_to :item

    # validates :image_link, presence: true
end