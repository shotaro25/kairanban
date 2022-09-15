class Post < ApplicationRecord

    has_one_attached :image
    belongs_to :user, optional: true
    has_many :favorites, dependent: :destroy

    validates :image, presence: true
    validates :is_active, inclusion: { in: [true, false] }

    #enum attendance:{join:0, not_join:1}

end
