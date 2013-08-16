class UserVote < ActiveRecord::Base
  attr_accessible :link_id, :user_id

  before_validation :check_previous_vote

  validates :user_id, :uniqueness => {:scope => :link_id}

  validates :choice, :presence => true

  def check_previous_vote
    opposite_vote = UserVote.where(:user_id => self.user_id,
    :link_id => self.link_id,
    :choice => opposite_choice ).first
    unless opposite_vote.nil?
      opposite_vote.destroy
    end
  end

  def opposite_choice
    self.choice == "up" ? "down" : "up"
  end
end
