# == Schema Information
# Schema version: 20101101014544
#
# Table name: client_perms
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  client_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class ClientPerm < ActiveRecord::Base
  belongs_to :user
  belongs_to :client
  attr_accessible :user_id, :client_id
end
