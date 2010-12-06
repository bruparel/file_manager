# == Schema Information
# Schema version: 20101101014544
#
# Table name: profiles
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  first_name :string(255)
#  last_name  :string(255)
#  theme      :string(255)     default("default")
#  help_on    :boolean         default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#

class Profile < ActiveRecord::Base

  belongs_to :user
  attr_accessible :first_name, :last_name
  validates :first_name, :last_name, :presence => true
    
end

