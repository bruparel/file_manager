require 'spec_helper'
describe Admin::BaseFoldersController do
  render_views

  before(:each) do
    @admin = Factory.create(:admin_user)
    @admin.confirm!
    sign_in @admin
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      assigns(:base_folders).should_not be_nil
      assigns(:search_fields_array).should_not be_nil
      response.should render_template('index')
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      assigns(:base_folder).should_not be_nil
      assigns(:flash).should be_nil
      response.should render_template('new')
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      @base_folder = Factory.create(:base_folder)
      get 'edit', :id => @base_folder.id
      assigns(:base_folder).should_not be_nil
      assigns(:flash).should be_nil
      response.should render_template('edit')
      response.should be_success
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @base_folder = Factory.create(:base_folder)
    end
    describe "failure" do
      before(:each) do
        @attr = { :name => '' }
      end
      it "should render the 'edit' page" do
        put :update, :id => @base_folder.id, :base_folder => @attr
        response.should render_template('edit')
      end
      it "should have the right heading" do
        put :update, :id => @base_folder.id, :base_folder => @attr
        response.should have_selector('h1', :content => "Editing Base Folder")
      end
    end
    describe "success" do
      before(:each) do
        @attr = { :name => "New folder" }
      end
      it "should change the base folder's name" do
        put :update, :id => @base_folder.id, :base_folder => @attr
        @base_folder.reload
        @base_folder.name.should == @attr[:name]
      end
      it "should have a flash message" do
        put :update, :id => @base_folder.id, :base_folder => @attr
        flash[:notice].should =~ /updated/
      end
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      @base_folder = Factory.create(:base_folder)
      get 'show', :id => @base_folder.id
      assigns(:base_folder).should == @base_folder
      assigns(:flash).should be_nil
      response.should render_template('show')
      response.should have_selector('h1', :content => "Base Folder")
      response.should be_success
    end
  end

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = { :name => "" }
      end
      it "should have the right heading" do
        post :create, :base_folder => @attr
        response.should have_selector('h1', :content => "New Base Folder")
      end
      it "should render the 'new' page" do
        post :create, :base_folder => @attr
        response.should render_template('new')
      end
      it "should not create a base folder" do
        lambda do
          post :create, :base_folder => @attr
        end.should_not change(BaseFolder, :count)
      end
    end
    describe "success" do
      before(:each) do
        @attr = { :name => "New Folder" }
      end
      it "should create a base folder" do
        lambda do
          post :create, :base_folder => @attr
        end.should change(BaseFolder, :count).by(1)
      end
      it "should redirect to the index page" do
        post :create, :base_folder => @attr
        response.should redirect_to(admin_base_folders_path)
      end
      it "should have a success message" do
        post :create, :base_folder => @attr
        flash[:notice].should =~ /successfully/i
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @base_folder = Factory.create(:base_folder)
    end
    it "should redirect to the index page" do
      delete :destroy, :id => @base_folder.id
      response.should redirect_to(admin_base_folders_path)
    end
    it "should have a successful deletion message" do
      delete :destroy, :id => @base_folder.id
      flash[:alert].should =~ /destroyed/i
    end
    it "should destroy the base folder instance" do
      lambda do
        delete :destroy, :id => @base_folder.id
      end.should change(BaseFolder, :count).by(-1)
    end
  end

end
