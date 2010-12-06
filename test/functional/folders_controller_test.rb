require 'test_helper'

class FoldersControllerTest < ActionController::TestCase

  setup {Role.create(:name => 'eclient', :display_name => 'External Client')}
  
  context "Current User" do

    setup do
      @user = Factory(:admin_user)
      @user.confirm!
      sign_in @user
    end

    context "on GET to :index current client with no folders" do
      setup do
        @client = Factory(:client)
        get :index, {}, {:client_id => @client.id}
        show_response
      end
      should assign_to(:base_folders)
      should respond_with(:success)
      should render_template(:index)
    end

  end  

end
