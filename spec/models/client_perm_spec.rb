require 'spec_helper'
describe 'Associations' do
  before(:each) do
    @client_perm = Factory.create(:client_perm)
  end
  it "should have a user attribute" do
    @client_perm.should respond_to(:user)
  end
  it "should have a client attribute" do
    @client_perm.should respond_to(:client)
  end
end
