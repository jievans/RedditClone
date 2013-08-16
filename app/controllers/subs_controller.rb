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
        @links.each do |link|
          link.sub_ids = [@sub.id]
          link.user_id = current_user.id
          link.save!
        end

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
    @links = Link.find_by_sql([<<-SQL, params[:id]])
    SELECT links.*, SUM(CASE WHEN user_votes.choice = 'up'
        THEN 1
        WHEN user_votes.choice = 'down'
        THEN -1
        ELSE 0
      END) vote_sum
        FROM links
         LEFT JOIN user_votes
         ON user_votes.link_id = links.id
         JOIN link_subs
         ON link_subs.link_id = links.id
     WHERE (link_subs.sub_id = ?)
     GROUP BY (links.id)
   ORDER BY (vote_sum) DESC;
    SQL
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
