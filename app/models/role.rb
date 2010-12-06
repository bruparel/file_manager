# == Schema Information
# Schema version: 20101101014544
#
# Table name: roles
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  display_name :string(255)
#

class Role < ActiveRecord::Base
  has_many :users
  validates_presence_of     :name, :display_name
  validates_uniqueness_of   :name, :display_name
end
