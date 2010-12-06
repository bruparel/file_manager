# == Schema Information
# Schema version: 20101101014544
#
# Table name: clients
#
#  id               :integer         not null, primary key
#  client_name      :string(255)
#  contact_name     :string(255)
#  address1         :string(255)
#  address2         :string(255)
#  city             :string(255)
#  state            :string(255)
#  zip              :string(255)
#  phone            :string(255)
#  mobile           :string(255)
#  fax              :string(255)
#  comment          :text
#  client_status_id :integer
#  permit           :boolean
#  created_at       :datetime
#  updated_at       :datetime
#

class Client < ActiveRecord::Base

  belongs_to :client_status
  has_many   :folders
  has_many   :client_comments
  has_many   :users
  has_many   :client_perms
  has_many   :folder_perms

  attr_accessible :client_name, :contact_name, :address1, :address2, :city, :state, :zip,
    :phone, :mobile, :fax, :client_status_id, :user_id, :comment

  validates :contact_name, :address1, :city, :state, :zip, :phone, :presence => true
  validates :client_name, :presence => true, :uniqueness => true

end
