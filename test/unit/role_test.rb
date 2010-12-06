require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  context 'A Role instance' do
    setup do
      @role = Factory(:leader_role)
    end
    should validate_presence_of(:name)
    should validate_presence_of(:display_name)
    should validate_uniqueness_of(:name)
    should validate_uniqueness_of(:display_name)
    should have_many(:users)
  end
end
