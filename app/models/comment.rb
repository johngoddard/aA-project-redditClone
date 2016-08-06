class Comment < ActiveRecord::Base
  validates :content, :author_id, :post_id, presence: true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

  belongs_to :post

  belongs_to :parent,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: :Comment

  has_many :child_comments,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: :Comment

  has_many :votes, as: :votable

  def vote_score
    score = 0
    self.votes.each{|v| score += v.value}
    score
  end


end
