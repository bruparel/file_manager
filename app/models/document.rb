# == Schema Information
# Schema version: 20101101014544
#
# Table name: documents
#
#  id                 :integer         not null, primary key
#  folder_id          :integer
#  document_status_id :integer
#  title              :string(255)
#  description        :text
#  doc_file_name      :string(255)
#  doc_content_type   :string(255)
#  doc_file_size      :integer
#  doc_updated_at     :datetime
#  created_at         :datetime
#  updated_at         :datetime
#

class Document < ActiveRecord::Base
  belongs_to :document_status
  belongs_to :folder

  # has_attached_file :doc
  has_attached_file :doc,
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :path => ":attachment/:id/:style.:extension",
      :bucket => 'bharatfilemanager'

  validates_attachment_presence :doc
  # validates_attachment_size :doc, :less_than => 200.kilobytes
  validates_presence_of :title
  validates_uniqueness_of :title, :scope => :folder_id

  def status
    self.document_status.name
  end
  
end
