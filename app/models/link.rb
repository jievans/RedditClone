class Link < ActiveRecord::Base
  attr_accessible :description, :title, :url, :sub_ids

  has_many :link_subs,
  :class_name => "LinkSub",
  :foreign_key => :link_id,
  :primary_key => :id

  has_many :subs,
  :through => :link_subs,
  :source => :sub

  belongs_to :user,
  :class_name => "User",
  :foreign_key => :user_id,
  :primary_key => :id

  has_many :comments,
  :class_name => "Comment",
  :foreign_key => :link_id,
  :primary_key => :id

  has_many :votes,
  :class_name => "UserVote",
  :foreign_key => :link_id,
  :primary_key => :id

  def num_upvotes
    self.votes.where(:choice => "up").count
  end

  def num_downvotes
    self.votes.where(:choice => "down").count
  end

  def comments_by_parent
    parents_hash = {}
    self.comments.each do |comment|
      parents_hash[comment.parent_comment_id] ||= []
      parents_hash[comment.parent_comment_id] << comment
    end
    parents_hash
  end

end
