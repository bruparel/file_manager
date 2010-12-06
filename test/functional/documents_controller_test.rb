require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase

  setup {Role.create(:name => 'eclient', :display_name => 'External Client')}

  context "Current User" do

    setup do
      @client_user = Factory(:lead_user)
      set_current_user(@client_user)
    end

    context "on GET to :index" do
      setup do
        @folder = Factory(:folder)
        get :index, {}, {:user_id => @client_user.id, :client_id => @folder.client_id,
                         :folder_id => @folder.id}
      end
      should assign_to(:status_array)
      should assign_to(:search_fields_array)
      #should_render_a_form
      should respond_with(:success)
      should render_template(:index)
    end

    context "on GET to :new" do
      setup do
        @document = Factory(:document)
        get :new, {}, {:user_id => @client_user.id,
                       :client_id => @document.folder.client_id,
                       :folder_id => @document.folder_id}
      end
      should_not set_the_flash
      should assign_to(:document)
      #should_render_a_form
      should respond_with(:success)
      should render_template(:new)
    end

    context "on POST to :create with valid document data" do
      setup do
        @folder = Factory(:folder)
        @document_status = Factory(:document_status)
        post :create, {:document => {:title => 'New Picture',
                           :description => 'New Description',
                           :doc_file_name => '../../../public/images/br.png',
                           :doc_content_type => 'image/jpeg',
                           :document_status_id => @document_status.id,
                           :folder_id => @folder.id}},
                      {:user_id => @client_user.id, :client_id => @folder.client_id,
                       :folder_id => @folder.id}
      end
      should "increment the document count to 1 upon creation" do
        assert_equal 1, Document.count
      end
      should set_session(:user_id) { @client_user.id }
      should set_session(:client_id) { @folder.client_id }
      should set_session(:folder_id) { @folder.id}
      should assign_to(:document)
      should set_the_flash.to(/Successfully created document./)
      should redirect_to("the document's list") { documents_path }
    end

    context "on GET to :edit for a document record" do
      setup do
        @document = Factory(:document)
        get :edit, {:id => @document.id},
                   {:user_id => @client_user.id,
                    :client_id => @document.folder.client_id,
                    :folder_id => @document.folder_id}
      end
      should assign_to(:document)
      should respond_with(:success)
      should render_template(:edit)
      should_not set_the_flash
    end

    context "on PUT to :update an existing document data" do
      setup do
        @document = Factory(:document)
        put :update, {:id => @document.id, :document => {:title => 'New Picture',
                           :description => 'New Description',
                           :doc_file_name => '../../../public/images/br.png',
                           :doc_content_type => 'image/jpeg',
                           :document_status_id => @document.document_status_id,
                           :folder_id => @document.folder_id}},
                   {:user_id => @client_user.id,
                    :client_id => @document.folder.client_id,
                    :folder_id => @document.folder_id}
      end
      should "increment the document count to 1 upon creation" do
        assert_equal 1, Document.count
      end
      should set_session(:user_id) { @client_user.id }
      should set_session(:client_id) { @document.folder.client_id }
      should set_session(:folder_id) {@document.folder_id}
      should assign_to(:document)
      should set_the_flash.to(/Successfully updated document./)
      should redirect_to("the document's list") { documents_path }
    end

    context 'on DELETE to :destroy for a document record' do
      setup do
        @document = Factory(:document)
        delete :destroy, {:id => @document.id},
                   {:user_id => @client_user.id,
                    :client_id => @document.folder.client_id,
                    :folder_id => @document.folder_id}
       end
      should assign_to(:document)
      should set_the_flash.to(/Successfully deleted document./)
      should respond_with(:redirect)
      should redirect_to("Documents' list") { documents_url }
    end

    context 'on GET to :download a document record' do
      setup do
        @document = Factory(:document)
        @document.doc = File.new("#{Rails.root}/public/images/bl.png")
        @document.save
        get :download_document, {:id => @document.id},
                   {:user_id => @client_user.id,
                    :client_id => @document.folder.client_id,
                    :folder_id => @document.folder_id}
       end
      should assign_to(:document)
      should respond_with(:success)
    end

  end

end
