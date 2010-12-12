require 'spec_helper'
describe Admin::UsersController do
  render_views
  before(:each) do
    @admin = Factory.create(:admin_user)
    @admin.confirm!
    sign_in @admin
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      assigns(:users).should_not be_nil
      assigns(:search_fields_array).should_not be_nil
      assigns(:role_array).should_not be_nil
      response.should render_template('index')
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      assigns(:user).should_not be_nil
      assigns(:flash).should be_nil
      response.should render_template('new')
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      @user = Factory.create(:lead_user)
      get 'edit', :id => @user.id
      assigns(:user).should_not be_nil
      assigns(:flash).should be_nil
      response.should render_template(:edit)
      response.should be_success
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @user = Factory.create(:lead_user)
    end
    describe "failure" do
      before(:each) do
        @attr = {:email => '', :password => '123456', :password_confirmation => '123456',
                 :role_id => 2, :profile_attributes => {:first_name => 'Jim', :last_name => 'Jones'}}
      end
      it "should render the 'edit' page" do
        put :update, :id => @user.id, :user => @attr
        response.should render_template('edit')
      end
      it "should have the error class" do
        put :update, :id => @user.id, :user => @attr
        response.should have_selector('span.error')
      end
    end
    describe "success" do
      before(:each) do
        @attr = {:email => 'someone@example.com', :password => '123456', :password_confirmation => '123456',
                 :role_id => 2, :profile_attributes => {:first_name => 'Jim', :last_name => 'Jones'}}
      end
      it "should change the user's email" do
        put :update, :id => @user.id, :user => @attr
        @user.reload
        @user.email.should == @attr[:email]
      end
      it "should have a flash message" do
        put :update, :id => @user.id, :user => @attr
        flash[:notice].should =~ /updated/
      end
    end
  end
  
  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = {:email => '', :password => '123456', :password_confirmation => '123456',
                 :role_id => 2, :profile_attributes => {:first_name => 'Jim', :last_name => 'Jones'}}
      end
      it "should have the error class" do
        post :create, :user => @attr
        response.should have_selector('span.error')
      end
      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
    end
    describe "success" do
      before(:each) do
        @attr = {:email => 'someone@example.com', :password => '123456', :password_confirmation => '123456',
                 :role_id => 2, :profile_attributes => {:first_name => 'Jim', :last_name => 'Jones'}}
      end
      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      it "should redirect to the index page" do
        post :create, :user => @attr
        response.should redirect_to(admin_users_path)
      end
      it "should have a success message" do
        post :create, :user => @attr
        flash[:notice].should =~ /User account created/i
      end
    end
  end

  describe "GET 'set_current_staff_user'" do
    it "should be successful" do
      @user = Factory.create(:lead_user)
      get 'set_current_staff_user', :id => @user.id
      session[:staff_user_id].should == @user.id
      flash[:notice].should =~ /Current staff user set to/i
      response.should redirect_to(:controller => 'client_perms', :action => 'index')
    end
  end

  describe "GET 'change_status'" do
    it "should be successful" do
      @user = Factory.create(:lead_user)
      get 'change_status', :id => @user.id
      assigns(:user).should_not be_nil
      flash[:warning] =~ /in-active/i
      response.should redirect_to(admin_users_path)
    end
  end

  describe "GET 'confirm_user'" do
    it "should be successful" do
      @user = Factory.create(:lead_user)
      get 'confirm_user', :id => @user.id
      assigns(:user).should_not be_nil
      flash[:warning] =~ /Confirming user/i
      response.should redirect_to(admin_users_path)
    end
  end

end
