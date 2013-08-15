class LinkSub < ActiveRecord::Base
  attr_accessible :link_id, :sub_id

  belongs_to :sub,
  :class_name => "Sub",
  :foreign_key => :sub_id,
  :primary_key => :id

  belongs_to :link,
  :class_name => "Link",
  :foreign_key => :link_id,
  :primary_key => :id
end
