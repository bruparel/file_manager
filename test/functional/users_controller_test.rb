require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  setup do
    Role.create(:name => 'eclient', :display_name => 'External Client')
    Role.create(:name => 'staff',     :display_name => 'Staff')
  end

  context "Current User" do

    setup do
      @admin = Factory(:admin_user)
      set_current_user(@admin)
    end

    context "on GET to :index" do
      setup { get :index }
      should assign_to(:role_array)
      should assign_to(:search_fields_array)
      #should_render_a_form
      should respond_with(:success)
      should render_template(:index)
    end

    context "on GET to :new" do
      setup do
        @request    = ActionController::TestRequest.new
        @request.env['HTTPS'] = 'on'
        get :new
      end
      should_not set_the_flash
      should assign_to(:user)
      #should_render_a_form
      should respond_with(:success)
      should render_template(:new)
    end

    context "on POST to :create with valid user data" do
      setup do
        @request    = ActionController::TestRequest.new
        @request.env['HTTPS'] = 'on'
        create_user
      end
      should "increment the user count to 2 upon creation" do
        assert_equal 2, User.count
      end
      should set_session(:user_id) { @admin.id }
      should assign_to(:user)
      should set_the_flash.to(/User account created and is ready for use./)
      should redirect_to("the user's list") { users_path }
    end

    context "on GET to :edit for a user record" do
      setup do
        @request    = ActionController::TestRequest.new
        @request.env['HTTPS'] = 'on'
        @lead = Factory(:lead_user)
        get :edit, {:id => @lead.id}, {:user_id => @admin.id}
      end

      should assign_to(:user)
      should respond_with(:success)
      should render_template(:edit)
      should_not set_the_flash
      should "test if a user id and edited user id are the same" do
        assert_equal @lead.id, assigns(:user).id
      end

    end

    context "on PUT to :update an existing user data" do
      setup do
        @request    = ActionController::TestRequest.new
        @request.env['HTTPS'] = 'on'
        @lead  = Factory(:lead_user)
        update_user(@lead)
      end
      should "increment the user count to 2 upon creation" do
        assert_equal 2, User.count
      end
      should set_session(:user_id) { @admin.id }
      should assign_to(:user)
      should set_the_flash.to(/User data was successfully updated./)
      should redirect_to("the user's list") { users_path }
    end

    context "on PUT to :update an existing user status" do
      setup do
        @lead  = Factory(:lead_user)
        update_status(@lead)
      end
      should "increment the user count to 2 upon creation" do
        assert_equal 2, User.count
      end
      should set_session(:user_id) { @admin.id }
      should assign_to(:user)
      should set_the_flash.to(/Set user status to/)
      should redirect_to("the user's list") { users_path }
    end

    context "on PUT to :update an existing user theme" do
      setup do
        @request    = ActionController::TestRequest.new
        @request.env["HTTP_REFERER"] = users_url
        update_theme
      end
      should "total only 1 user" do
        assert_equal 1, User.count
      end
      should set_session(:user_id) { @admin.id }
      should set_the_flash.to(/Set the new theme to/)
      should respond_with(:redirect)
    end

    context "on PUT to :update (toggle) an existing user help" do
      setup do
        @request    = ActionController::TestRequest.new
        @request.env["HTTP_REFERER"] = users_url
        toggle_help_for_user
      end
      should "total only 1 user" do
        assert_equal 1, User.count
      end
      should set_session(:user_id) { @admin.id }
      should set_the_flash.to(/System wide help has been turned/)
      should respond_with(:redirect)
    end

  end

  protected

  def create_user
    # assumes that a role exists
    role = Factory(:leader_role)
    post :create, {:user => { :username => 'test_user', :display_name => 'Test User', :email => 'tu@example.com',
      :password => 'test_pass', :password_confirmation => 'test_pass', :role_id => role.id}},
      {:user_id => @admin.id}
  end

  def update_user(this_user)
    put :update, { :id => this_user.id, :user => {:username => 'new_user', :display_name => 'New User', :email => 'nu@example.com',
      :password => 'new_pass', :password_confirmation => 'new_pass', :role_id => this_user.role_id}},
      {:user_id => @admin.id}
  end

  def update_status(this_user)
    put :change_status, {:id => this_user.id}, {:user_id => @admin.id}
  end

  def update_theme
    put :set_theme, {:id => 'default'}, {:user_id => @admin.id}
  end

  def toggle_help_for_user
    put :toggle_help, {:id => @admin.id}, {:user_id => @admin.id}
  end

end
