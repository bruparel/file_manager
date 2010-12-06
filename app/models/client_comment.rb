# == Schema Information
# Schema version: 20101101014544
#
# Table name: client_comments
#
#  id         :integer         not null, primary key
#  content    :text            default("")
#  client_id  :integer
#  user_id    :integer
#  delta      :boolean
#  created_at :datetime
#  updated_at :datetime
#

class ClientComment < ActiveRecord::Base
  belongs_to :client
  belongs_to :user
  attr_accessible :content, :client_id, :user_id
  validates_presence_of :content, :message => "^Empty comment/notes cannot be saved."  

  # define_index do
  #   indexes content
  #   has client_id, created_at
  #   set_property :delta => true
  # end

end
