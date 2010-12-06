require 'spec_helper'
describe ClientStatus do
  describe "validate name" do
    it "Client status cannot be saved without a name" do
      client_stat = Factory.build(:client_status, :name => '')
      client_stat.should have(1).error_on(:name)
      client_stat.should_not be_valid
    end
    it "Client status should be valid with a name" do
      client_stat = Factory.create(:client_status)
      client_stat.should be_valid
    end
    it "Client status should enforce uniqueness constraint on name" do
      client_stat1 = Factory.create(:client_status)
      client_stat2 = Factory.build(:client_status, :name => client_stat1.name)
      client_stat2.should have(1).error_on(:name)
      client_stat2.should_not be_valid
    end
  end
  describe "Client associations" do
    before(:each) do
      @client_status = Factory.create(:client_status)
      @client1 = Factory.create(:client, :client_status => @client_status)
      @client2 = Factory.create(:client, :client_status => @client_status, :client_name => "Another title")
    end
    it "should have a clients attribute" do
      @client_status.should respond_to(:clients)
      @client_status.should have(2).clients
    end
  end
end

