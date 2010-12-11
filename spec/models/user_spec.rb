require 'spec_helper'
describe User do
  # we are not going to validate required and unique email attribute since
  # it is being done by Devise which is a Rails 3 Engine,  refer to the following
  # thread
  # http://groups.google.com/group/plataformatec-devise/browse_thread/thread/fc802417e9e48a53 
  # This leaves the associations :role and :profile to be tested
  describe "Role association" do
    before(:each) do
      @role = Factory.create(:admin_role)
      user  = Factory.build(:admin_user)
      @user = @role.users.create(user)
    end
    it "should have a role attribute" do
      @user.should respond_to(:role)
    end
    it "should have the right role value" do
      @user.role.should == @role
    end
  end
  describe "Profile association" do
    before(:each) do
      @user = Factory.create(:admin_user)
      # @profile = Factory.create(:admin_profile, :user => @user)
    end
    it "should have a profile attribute" do
      @user.should respond_to(:profile)
    end
    it "should not let us create multiple profiles for a user" do
      @user.should_not respond_to(:profiles)
    end
    it "should have built nested profile attribute automatically" do
      @user.profile.first_name == 'System'
      @user.profile.last_name  == 'Administrator'
    end
  end
end
