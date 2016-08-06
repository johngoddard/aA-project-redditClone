class Vote < ActiveRecord::Base
  validates :value, :user_id, :votable_id, :votable_type, presence: true
  validates :value, inclusion: [-1, 1]
  validates :votable_type, inclusion: ["Post", "Comment"]
  validates :user_id, uniqueness: {scope: [:votable_id, :votable_type]}

  belongs_to :votable, polymorphic: true
  belongs_to :user
end
