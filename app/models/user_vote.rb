class UserVote < ActiveRecord::Base
  attr_accessible :link_id, :user_id

  validates :user_id, :uniqueness => {:scope => :link_id}
end
