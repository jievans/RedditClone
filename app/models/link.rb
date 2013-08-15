class Link < ActiveRecord::Base
  attr_accessible :description, :title, :url, :sub_ids

  has_many :link_subs,
  :class_name => "LinkSub",
  :foreign_key => :link_id,
  :primary_key => :id

  has_many :subs,
  :through => :link_subs,
  :source => :sub
end
