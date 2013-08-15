class SubsController < ApplicationController

  before_filter :authorized?, :only => [:edit, :update]

  def new
    render :new
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        @sub = current_user.subs.new(params[:sub])

        @links = []
        params[:links].each do | _, attributes_hash |
          next if attributes_hash.any? {|key, value| value.empty? }
          @links << Link.new(attributes_hash)
        end

        @sub.save!
        @links.each { |link| link.sub_ids = [@sub.id]; link.save! }

        redirect_to sub_url(@sub)
      end
    rescue => e
      render :text => e.message
    end
  end

  def edit
    @sub = Sub.find_by_id(params[:id])
  end

  def update
    @sub = Sub.find_by_id(params[:id])
    @sub.update_attributes!(params[:sub])
    redirect_to sub_url(@sub)
  end

  def show
    @sub = Sub.find_by_id(params[:id])
    render :show
  end

  private

  def authorized?
    @sub = Sub.find_by_id(params[:id])
    unless @sub.moderator_id == current_user.id
      flash[:notices] ||= []
      flash[:notices] << "You are not allowed to edit that sub!"
      redirect_to user_url(current_user)
    end
  end

end
