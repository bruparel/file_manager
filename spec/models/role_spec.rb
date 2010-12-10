require 'spec_helper'
describe Role do
  describe 'validate name' do
    it "Role cannot be saved without a name" do
      role = Factory.build(:admin_role, :name => '')
      role.should have(1).error_on(:name)
      role.should_not be_valid
    end
    it "Role should be valid with a name" do
      role = Factory.create(:admin_role)
      role.should be_valid
    end
    it "Role should enforce uniqueness constraint on name" do
      role1 = Factory.create(:admin_role)
      role2 = Factory.build(:admin_role, :name => role1.name)
      role2.should have(1).error_on(:name)
      role2.should_not be_valid
    end
  end
  describe "User associations" do
    before(:each) do
      @role = Factory.create(:admin_role)
      @user1 = Factory.create(:admin_user, :role => @role)
      @user2 = Factory.create(:admin_user, :role => @role, :email => "someone@example.com")
    end
    it "should have a users attribute" do
      @role.should respond_to(:users)
      @role.should have(2).users
    end
  end
end
