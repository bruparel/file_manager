require 'test_helper'

class FolderTest < ActiveSupport::TestCase
  context 'A Folder instance' do
    setup do
      @folder = Factory(:folder)
    end
    should have_many(:documents)
    should belong_to(:client)
    should allow_mass_assignment_of(:name)
    should allow_mass_assignment_of(:eclient_flag)
    should allow_mass_assignment_of(:client_id)
    should allow_mass_assignment_of(:parent_id)
    should validate_presence_of(:name).with_message("^You must specify a folder name.")
  end
end
