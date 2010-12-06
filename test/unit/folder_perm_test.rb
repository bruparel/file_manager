require 'test_helper'

class FolderPermTest < ActiveSupport::TestCase
  context 'A Folder Permission instance' do
    setup do
      Role.create(:name => 'eclient', :display_name => 'External Client')
      @folder_perm = Factory(:folder_perm)
    end
    should belong_to(:user)
    should belong_to(:folder)
    should allow_mass_assignment_of(:user_id)
    should allow_mass_assignment_of(:client_id)
    should allow_mass_assignment_of(:folder_id)
  end
end
