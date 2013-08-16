class LinksController < ApplicationController

  before_filter :authorized?, :only => [:edit, :update]

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

    redirect_to link_url(params[:id])
  end

  def upvote
    vote = UserVote.new(:link_id => params[:id])
    vote.user_id = current_user.id
    vote.choice = "up"
    vote.save!

    redirect_to link_url(params[:id])
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
