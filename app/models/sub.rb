class Sub < ActiveRecord::Base
  belongs_to :moderator,
    class_name: "User"

  has_many :post_crosses,
    foreign_key: :post_id,
    class_name: "PostSub"

  has_many :posts,
    through: :post_crosses,
    source: :post

  validates :moderator, presence: true
  validates :title, :description, presence: true
end
