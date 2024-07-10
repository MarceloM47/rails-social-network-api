class Like
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id, message: "can only like a post once" }
end
