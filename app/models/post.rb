

class Post < ActiveRecord::Base

  belongs_to :author,
    class_name: "User"

  has_many :cross_posts,
    foreign_key: :post_id,
    class_name: "PostSub"

  has_many :subs,
    through: :cross_posts,
    source: :post

end
