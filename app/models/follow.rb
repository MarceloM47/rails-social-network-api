class Follow
    include Mongoid::Document
    include Mongoid::Timestamps
  
    belongs_to :follower, class_name: 'User', inverse_of: :active_follows
    belongs_to :followee, class_name: 'User', inverse_of: :passive_follows
  
    validates :follower, presence: true
    validates :followee, presence: true
    validates :follower_id, uniqueness: { scope: :followee_id }  
end