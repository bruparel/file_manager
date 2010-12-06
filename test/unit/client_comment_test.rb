require 'test_helper'

class ClientCommentTest < ActiveSupport::TestCase
  context 'A Client comment instance' do
    setup do
      Role.create(:name => 'eclient', :display_name => 'External Client')
      @client_comment = Factory(:client_comment)
    end
    
    should belong_to(:client)
    should belong_to(:user)
    should allow_mass_assignment_of(:content)
    should validate_presence_of(:content).with_message("^Empty comment/notes cannot be saved.")
  end
end
