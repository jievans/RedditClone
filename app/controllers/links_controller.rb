class LinksController < ApplicationController

  before_filter :authorized?, :only => [:edit, :update]

  def new
    @link = Link.new
    render :new
  end

  def create
    link = current_user.links.create!(params[:link])
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
