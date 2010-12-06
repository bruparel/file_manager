# == Schema Information
# Schema version: 20101101014544
#
# Table name: document_statuses
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class DocumentStatus < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true, :uniqueness => true
  has_many :documents
end
