class LinksController < ApplicationController

  before_filter :authorized?, :only => [:edit, :update]

  def index
    @all_links = Link.find_by_sql([<<-SQL, params[:id]])
    SELECT links.*, SUM(CASE WHEN user_votes.choice = 'up'
        THEN 1
        WHEN user_votes.choice = 'down'
        THEN -1
        ELSE 0
      END) vote_sum
        FROM links
         LEFT JOIN user_votes
         ON user_votes.link_id = links.id
     GROUP BY (links.id)
   ORDER BY (vote_sum) DESC;
    SQL
  end

  def new
    @link = Link.new
    render :new
  end

  def create
    link = current_user.links.create!(params[:link])
    if params[:comment]
      comment = Comment.new(params[:comment])
      comment.link_id = link.id
      comment.save!
    end
    redirect_to link_url(link)
  end

  def edit
    @link = Link.find_by_id(params[:id])
    render :edit
  end

  def update
    @link = Link.find_by_id(params[:id])
    @link.update_attributes(params[:link])
    redirect_to link_url(@link)
  end

  def show
    @link = Link.find_by_id(params[:id])
  end

  def downvote
    vote = UserVote.new(:link_id => params[:id])
    vote.user_id = current_user.id
    vote.choice = "down"
    vote.save!

    #redirect_to link_url(params[:id])
    redirect_to :back
  end

  def upvote
    vote = UserVote.new(:link_id => params[:id])
    vote.user_id = current_user.id
    vote.choice = "up"
    vote.save!

    redirect_to :back
  end

  private

  def authorized?
    @link = Link.find_by_id(params[:id])
    unless @link.user_id == current_user.id
      flash[:notices] ||= []
      flash[:notices] << "You are not allowed to edit that link!"
      redirect_to user_url(current_user)
    end
  end

end
