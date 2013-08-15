class SubsController < ApplicationController
  def new
    render :new
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        @sub = current_user.subs.new(params[:sub])

        @links = []
        params[:links].each do | _, attributes_hash |
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

  def show
    @sub = Sub.find_by_id(params[:id])
    render :show
  end

end
