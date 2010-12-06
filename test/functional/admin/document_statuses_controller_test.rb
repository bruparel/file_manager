require 'test_helper'

class Admin::DocumentStatusesControllerTest < ActionController::TestCase

  setup {Role.create(:name => 'eclient', :display_name => 'External Client')}

  context "Current user" do

    setup do
      @admin = Factory(:admin_user)
      @admin.confirm!
      sign_in @admin
    end

    context "on GET to :index" do
      setup { get :index }
      should assign_to(:document_statuses)
      should assign_to(:search_fields_array)
      should respond_with(:success)
      should render_template(:index)
    end

    context "on GET to :new" do
      setup { get :new }
      should_not set_the_flash
      should assign_to(:document_status)
      should respond_with(:success)
      should render_template(:new)
    end

    context "on GET to :edit for document status record" do
      setup do
        @document_status = Factory(:document_status)
        get :edit, {:id => @document_status.id}
      end
      should assign_to(:document_status)
      should respond_with(:success)
      should render_template(:edit)
      should_not set_the_flash
    end

    context "on PUT to :update an existing document status record" do
      setup do
        @document_status = Factory(:document_status)
        put :update, { :id => @document_status.id, :document_status => {:name => 'New Status'}}
      end
      should "Keep the document status count to 1 upon update" do
        assert_equal 1, DocumentStatus.count
      end
      should assign_to(:document_status)
      should set_the_flash.to(/Document status was successfully updated./)
      should redirect_to("the document statuses' list") { admin_document_statuses_path }
    end

    context "on GET to :show for an existing document status record" do
      setup do
        @document_status = Factory(:document_status)
        get :show, {:id => @document_status.id}
      end
      should assign_to(:document_status)
      should respond_with(:success)
      should render_template(:show)
      should_not set_the_flash
    end

    context 'on DELETE to :destroy for a document status record' do
      setup do
        @document_status = Factory(:document_status)
        delete :destroy, {:id => @document_status.id}
      end
      should assign_to(:document_status)
      should set_the_flash.to(/Document status sucessfully destroyed/)
      should respond_with(:redirect)
      should redirect_to("Document statuses' list") {admin_document_statuses_path }
    end

  end

end

