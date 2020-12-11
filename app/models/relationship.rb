class Relationship < ApplicationRecord
  # followerに属する
  belongs_to :follower, class_name: "User"
  # followerに属する
  belongs_to :followed, class_name: "User"
  # follower_idを所有する
  validates :follower_id, presence: true
  # follower_idを所有する
  validates :followed_id, presence: true
end
