require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase

  should 'redirect to login page' do
    assert_nothing_raised do
      get :index
      assert_response :redirect
      assert_redirected_to login_url
    end
  end

  should 'display privacy statement' do
    assert_nothing_raised do
      get :display_privacy_statement
      assert_response :success
      assert_template 'display_privacy_statement'
    end
  end

  context 'A logged_in external client user' do
    setup do
      @eclient_user = Factory(:eclient_user)
      set_current_user(@eclient_user)
    end

    should 'be able to see welcome index page without being redirected' do
      assert_nothing_raised do
        get :index
        assert_response :success
        assert_template 'index'
      end
    end
  end

end
