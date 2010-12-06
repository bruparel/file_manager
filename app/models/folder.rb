# == Schema Information
# Schema version: 20101101014544
#
# Table name: folders
#
#  id           :integer         not null, primary key
#  parent_id    :integer
#  name         :string(255)
#  client_id    :integer
#  permit       :boolean
#  eclient_flag :boolean
#  created_at   :datetime
#  updated_at   :datetime
#

class Folder < ActiveRecord::Base

  acts_as_tree :order => "name"

  scope :sibling_folders, lambda { |parent_id| {:conditions => {:parent_id => parent_id} } }

  has_many :documents
  has_many :folder_perms
  belongs_to :client

  attr_accessible :name, :eclient_flag, :client_id, :parent_id
  validates :name, :presence => true, :uniqueness => {:scope => :client_id}
  validates :client_id, :presence => true

  def owner
    self.client.client_name
  end
  
end
