require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  context 'A Document instance' do
    setup do
      @document = Factory(:document)
    end
    #should have_attached_file(:doc)
    should belong_to(:document_status)
    should validate_presence_of(:title)
  end
end
