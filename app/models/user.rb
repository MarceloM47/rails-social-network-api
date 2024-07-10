class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  field :username, type: String
  field :email, type: String
  field :password_digest, type: String

  has_secure_password
  has_many :posts
  has_many :likes

  has_many :active_follows, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy, inverse_of: :follower
  has_many :passive_follows, class_name: 'Follow', foreign_key: 'followee_id', dependent: :destroy, inverse_of: :followee

  def following
    User.in(id: active_follows.pluck(:followee_id))
  end

  def followers
    User.in(id: passive_follows.pluck(:follower_id))
  end

  validates :username, :email, presence: { message: "All fields are required" }
  validates :password, presence: true, confirmation: true, on: :create

  attr_accessor :password_confirmation

  def authenticate(password)
    BCrypt::Password.new(password_digest) == password
  end
end
