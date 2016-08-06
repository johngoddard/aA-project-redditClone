class Post < ActiveRecord::Base
  validates :title, :author, presence: true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :post_subs, source: :sub
  has_many :comments
  has_many :votes, as: :votable

  def comments_by_parent_id
    h = Hash.new { |h, k| h[k] = [] }
    self.comments.each do |comment|
      h[comment.parent_comment_id] << comment
    end

    h
  end

  def vote_score
    score = 0
    self.votes.each{|v| score += v.value}
    score
  end
end
