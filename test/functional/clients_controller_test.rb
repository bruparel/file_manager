require 'test_helper'

class ClientsControllerTest < ActionController::TestCase

  setup {Role.create(:name => 'eclient', :display_name => 'External Client')}

  context "Current User" do

    setup do
      @user = Factory(:lead_user)
      @user.confirm!
      sign_in @user
    end

    context "on GET to :index" do
      setup { get :index }
      should assign_to(:status_array)
      should assign_to(:search_fields_array)
      should respond_with(:success)
      should render_template(:index)
    end

    context "on GET to :new" do
      setup do
        @client_status = Factory(:client_status)
        get :new
      end
      should_not set_the_flash
      should assign_to(:client)
      should respond_with(:success)
      should render_template(:new)
      should "do the following two assignments" do
        assert_equal @client_status, assigns(:client).client_status
        assert_equal 'TX', assigns(:client).state
      end
    end

    context "on POST to :create with valid user data" do
      setup { create_client }
      should "increment the client count to 1 upon creation" do
        assert_equal 1, Client.count
      end
      # should set_session(:user_id) { @user.id }
      should set_session(:client_id) { assigns(:client).id}
      should assign_to(:client)
      should set_the_flash.to(/Basic Info successfully saved/)
      should redirect_to("the folders list") { folders_path }
    end

    context "on GET to :edit for client record" do
      setup do
        @client = Factory(:client)
        get :edit, {:id => @client.id}
      end
      should assign_to(:client)
      should respond_with(:success)
      should render_template(:edit)
      should_not set_the_flash
    end

    context "on PUT to :update an existing client data" do
      setup do
        @client = Factory(:client)
        update_client(@client)
      end
      should "get the client count equal to 1" do
        assert_equal 1, Client.count
      end
      should assign_to(:client)
      should set_the_flash.to(/Client data was successfully updated./)
      should redirect_to("Clients' list") {clients_path }
    end

    context 'on DELETE to :destroy for a client record' do
      setup do
        @client = Factory(:client)
        delete :destroy, {:id => @client.id}
      end
      should assign_to(:client)
      should set_the_flash.to(/Successfully destroyed client record./)
      should respond_with(:redirect)
      should redirect_to("Clients' list") {clients_path }
    end

    context "on GET to :set_current_client" do
      setup do
        @client = Factory(:client)
        get :set_current_client, {:id => @client.id}
      end
      should "total only 1 client" do
        assert_equal 1, Client.count
      end
      should set_session(:client_id) {@client.id}
      should set_the_flash.to(/Current client set to/)
      should redirect_to("Folders list") {folders_path }
    end

  end
  
  protected

  def create_client
    client_status = Factory(:client_status)
    post :create, {:client => { :client_name => 'New Client', :contact_name => 'Client Contact',
                   :address1 => '123 Main Street', :city => 'Lubbock', :state => 'Texas', :zip => '79409',
                   :phone => '444-444-4444', :mobile => '555-555-5555', :fax => '666-666-6666',
                   :comment => 'New client comment', :client_status_id => client_status.id}}
  end

  def update_client(this_client)
    put :update, { :id => this_client.id, :client => { :client_name => 'New Client', :contact_name => 'Client Contact',
                   :address1 => '123 Main Street', :city => 'Lubbock', :state => 'Texas', :zip => '79409',
                   :phone => '444-444-4444', :mobile => '555-555-5555', :fax => '666-666-6666',
                   :comment => 'New client comment', :client_status_id => @client.client_status.id}}
  end

end
