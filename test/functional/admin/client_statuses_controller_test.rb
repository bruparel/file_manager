require 'test_helper'

class Admin::ClientStatusesControllerTest < ActionController::TestCase

  setup {Role.create(:name => 'eclient', :display_name => 'External Client')}

  context "Current user" do

    setup do
      @admin = Factory(:admin_user)
      @admin.confirm!
      sign_in @admin
    end

    context "on GET to :index" do
      setup { get :index }
      should assign_to(:client_statuses)
      should assign_to(:search_fields_array)
      should respond_with(:success)
      should render_template(:index)
    end

    context "on GET to :new" do
      setup { get :new }
      should_not set_the_flash
      should assign_to(:client_status)
      should respond_with(:success)
      should render_template(:new)
    end

    context "on GET to :edit for client status record" do
      setup do
        @client_status = Factory(:client_status)
        get :edit, {:id => @client_status.id}
      end
      should assign_to(:client_status)
      should respond_with(:success)
      should render_template(:edit)
      should_not set_the_flash
    end

    context "on PUT to :update an existing client status record" do
      setup do
        @client_status = Factory(:client_status)
        put :update, { :id => @client_status.id, :client_status => {:name => 'New Status'}}
      end
      should "Keep the client status count to 1 upon update" do
        assert_equal 1, ClientStatus.count
      end
      should assign_to(:client_status)
      should set_the_flash.to(/Client status was successfully updated./)
      should redirect_to("the client statuses' list") { admin_client_statuses_path }
    end

    context "on GET to :show for an existing client status record" do
      setup do
        @client_status = Factory(:client_status)
        get :show, {:id => @client_status.id}
      end
      should assign_to(:client_status)
      should respond_with(:success)
      should render_template(:show)
      should_not set_the_flash
    end

    context 'on DELETE to :destroy for a client status record' do
      setup do
        @client_status = Factory(:client_status)
        delete :destroy, {:id => @client_status.id}
      end
      should assign_to(:client_status)
      should set_the_flash.to(/Client status sucessfully destroyed/)
      should respond_with(:redirect)
      should redirect_to("Client statuses' list") {admin_client_statuses_path }
    end

  end

end
