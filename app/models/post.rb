class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  field :content, type: String

  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :content, :user, presence: { message: "Content and user are required" }
  validates :content, length: {
    minimum: 10,
    maximum: 300,
    too_short: "Content must have at least %{count} characters",
    too_long: "Content cannot exceed %{count} characters"
  }
end
