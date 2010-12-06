# == Schema Information
# Schema version: 20101101014544
#
# Table name: folder_perms
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  client_id  :integer
#  folder_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class FolderPerm < ActiveRecord::Base
  belongs_to :user
  belongs_to :client
  belongs_to :folder
  attr_accessible :user_id, :client_id, :folder_id
end
