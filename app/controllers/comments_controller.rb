class CommentsController < ApplicationController

  def create
    comment = Comment.create!(params[:comment])
    redirect_to comment_url(comment)
  end

  def show
    @comment = Comment.find_by_id(params[:id])
    render :show
  end


end
