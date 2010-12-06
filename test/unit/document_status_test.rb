require 'test_helper'

class DocumentStatusTest < ActiveSupport::TestCase
  context 'A DocumentStatus instance' do
    setup do
      @document_status = Factory(:document_status)
    end
    should allow_mass_assignment_of(:name)
    should validate_presence_of(:name).with_message("^You must specify a document status name.")
    should validate_uniqueness_of(:name)
    should have_many(:documents)
  end
end
