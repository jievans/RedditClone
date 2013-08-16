class Comment < ActiveRecord::Base
  attr_accessible :body, :link_id, :parent_comment_id

  belongs_to :parent_comment,
  :class_name => "Comment",
  :foreign_key => :parent_comment_id,
  :primary_key => :id

  has_many :child_comments,
  :class_name => "Comment",
  :foreign_key => :parent_comment_id,
  :primary_key => :id
end
