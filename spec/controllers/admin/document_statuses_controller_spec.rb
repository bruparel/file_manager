require 'spec_helper'
describe Admin::DocumentStatusesController do
  render_views

  before(:each) do
    @admin = Factory.create(:admin_user)
    @admin.confirm!
    sign_in @admin
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      assigns(:document_statuses).should_not be_nil
      assigns(:search_fields_array).should_not be_nil
      response.should render_template('index')
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      assigns(:document_status).should_not be_nil
      assigns(:flash).should be_nil
      response.should render_template('new')
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      @document_status = Factory.create(:document_status)
      get 'edit', :id => @document_status.id
      assigns(:document_status).should_not be_nil
      assigns(:flash).should be_nil
      response.should render_template('edit')
      response.should be_success
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @document_status = Factory.create(:document_status)
    end
    describe "failure" do
      before(:each) do
        @attr = { :name => '' }
      end
      it "should render the 'edit' page" do
        put :update, :id => @document_status.id, :document_status => @attr
        response.should render_template('edit')
      end
      it "should have the right heading" do
        put :update, :id => @document_status.id, :document_status => @attr
        response.should have_selector('h1', :content => "Editing Document Status")
      end
    end
    describe "success" do
      before(:each) do
        @attr = { :name => "New document status" }
      end
      it "should change the document status's name" do
        put :update, :id => @document_status.id, :document_status => @attr
        @document_status.reload
        @document_status.name.should == @attr[:name]
      end
      it "should have a flash message" do
        put :update, :id => @document_status.id, :document_status => @attr
        flash[:notice].should =~ /updated/
      end
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      @document_status = Factory.create(:document_status)
      get 'show', :id => @document_status.id
      assigns(:document_status).should == @document_status
      assigns(:flash).should be_nil
      response.should render_template('show')
      response.should have_selector('h1', :content => "Document Status")
      response.should be_success
    end
  end

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = { :name => "" }
      end
      it "should have the right heading" do
        post :create, :document_status => @attr
        response.should have_selector('h1', :content => "New Document Status")
      end
      it "should render the 'new' page" do
        post :create, :document_status => @attr
        response.should render_template('new')
      end
      it "should not create a document status" do
        lambda do
          post :create, :document_status => @attr
        end.should_not change(BaseFolder, :count)
      end
    end
    describe "success" do
      before(:each) do
        @attr = { :name => "New Document Status" }
      end
      it "should create a document status" do
        lambda do
          post :create, :document_status => @attr
        end.should change(DocumentStatus, :count).by(1)
      end
      it "should redirect to the index page" do
        post :create, :document_status => @attr
        response.should redirect_to(admin_document_statuses_path)
      end
      it "should have a success message" do
        post :create, :document_status => @attr
        flash[:notice].should =~ /successfully/i
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @document_status = Factory.create(:document_status)
    end
    it "should redirect to the index page" do
      delete :destroy, :id => @document_status.id
      response.should redirect_to(admin_document_statuses_path)
    end
    it "should have a successful deletion message" do
      delete :destroy, :id => @document_status.id
      flash[:alert].should =~ /destroyed/i
    end
    it "should destroy the document status instance" do
      lambda do
        delete :destroy, :id => @document_status.id
      end.should change(DocumentStatus, :count).by(-1)
    end
  end

end


