class LinksController < ApplicationController

  def new
    @link = Link.new
    render :new
  end

  def create
    link = Link.create!(params[:link])
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
end
