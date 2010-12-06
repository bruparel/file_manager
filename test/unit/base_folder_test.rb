require 'test_helper'

class BaseFolderTest < ActiveSupport::TestCase
  context 'A Base Folder instance' do
    setup do
      @base_folder = Factory(:base_folder)
    end

    should allow_mass_assignment_of(:name)
    should validate_presence_of(:name).with_message(/You must specify a base folder name/)

  end
end
