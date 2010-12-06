# == Schema Information
# Schema version: 20101101014544
#
# Table name: client_statuses
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ClientStatus < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  has_many :clients
end
