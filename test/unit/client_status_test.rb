require 'test_helper'

class ClientStatusTest < ActiveSupport::TestCase
  context 'A Client Status instance' do
    setup do
      @client_status = Factory(:client_status)
    end

    should allow_mass_assignment_of(:name)
    should validate_presence_of(:name).with_message( "^You must specify a client status name.")
    should have_many(:clients)
    
  end
end
