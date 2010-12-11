require 'spec_helper'
describe Profile do
  describe 'validate first name' do
    it 'Profile cannot be saved without a first name' do
      profile = Factory.build(:admin_profile, :first_name => '')
      profile.should have(1).error_on(:first_name)
      profile.should_not be_valid
    end
  end
  describe 'validate last name' do
    it 'Profile cannot be saved without a last name' do
      profile = Factory.build(:admin_profile, :last_name => '')
      profile.should have(1).error_on(:last_name)
      profile.should_not be_valid
    end
  end
  describe "User association" do
    before(:each) do
      @user    = User.create(:email => 'this@example.com', :password => "123456", :password_confirmation => "123456")
      @profile = Factory.create(:admin_profile, :user_id => @user.id)
    end
    it "should have a user attribute" do
      @profile.should respond_to(:user)
    end
    it "should match the exact user" do
      @profile.user == @user
    end
  end
end
