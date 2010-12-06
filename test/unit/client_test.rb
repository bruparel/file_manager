require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  context 'A Client instance' do
    setup do
      @client = Factory(:client)
    end

    should belong_to(:client_status)
    should have_many(:client_comments)
    should have_many(:folders)
    # should have_many(:users)
    should allow_mass_assignment_of(:client_name)
    should validate_presence_of(:client_name)
    should validate_presence_of(:contact_name)
    should validate_presence_of(:address1)
    should validate_presence_of(:city)
    should validate_presence_of(:state)
    should validate_presence_of(:zip)
    should validate_presence_of(:phone)
    should validate_uniqueness_of(:client_name)
  end
end
