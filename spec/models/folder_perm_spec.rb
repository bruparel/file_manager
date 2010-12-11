require 'spec_helper'
describe 'Associations' do
  before(:each) do
    @folder_perm = Factory.create(:folder_perm)
  end
  it "should have a user attribute" do
    @folder_perm.should respond_to(:user)
  end
  it "should have a client attribute" do
    @folder_perm.should respond_to(:client)
  end
  it "should have a folder attribute" do
    @folder_perm.should respond_to(:folder)
  end
end
