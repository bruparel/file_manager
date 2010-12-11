require 'spec_helper'
describe Admin::BaseFoldersController do
  render_views

  before(:each) do
    @admin = Factory(:admin_user)
    @admin.confirm!
    sign_in @admin
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
  
end
