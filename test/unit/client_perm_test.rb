require 'test_helper'

class ClientPermTest < ActiveSupport::TestCase
  context 'A Client Permission instance' do
    setup do
      Role.create(:name => 'eclient', :display_name => 'External Client')
      @client_perm = Factory(:client_perm)
    end
    should belong_to(:user)
    should belong_to(:client)
    should allow_mass_assignment_of(:user_id)
    should allow_mass_assignment_of(:client_id)
  end
end
