require 'spec_helper'
describe Client do

  describe "validate required attributes and uniqueness constraints" do
    it "should create a new instance given a valid set of attributes" do
      Factory.create(:client).should be_valid
    end
    it "should require a client name" do
      Factory.build(:client, :client_name => '').should_not be_valid
    end
    it "should require a contact name" do
      Factory.build(:client, :contact_name => '').should_not be_valid
    end
    it "should require an address" do
      Factory.build(:client, :address1 => '').should_not be_valid
    end
    it "should require a city" do
      Factory.build(:client, :city => '').should_not be_valid
    end
    it "should require a state" do
      Factory.build(:client, :state => '').should_not be_valid
    end
    it "should require a zip" do
      Factory.build(:client, :zip => '').should_not be_valid
    end
    it "should require a phone" do
      Factory.build(:client, :phone => '').should_not be_valid
    end
    it "should enforce uniqueness constraint on client name" do
      client1 = Factory.create(:client)
      client2 = Factory.build(:client, :client_name => client1.client_name)
      client2.should have(1).error_on(:client_name)
      client2.should_not be_valid
    end
  end

  describe "Client Status association" do
    before(:each) do
      @client_status = Factory.create(:client_status)
      client = Factory.build(:client)
      @client = @client_status.clients.create(client)
    end
    it "should have a client status attribute" do
      @client.should respond_to(:client_status)
    end
    it "should have the right client status value" do
      @client.client_status.should == @client_status
    end
  end

  describe "Folders associations" do
    before(:each) do
      @client = Factory.create(:client)
      @folder1 = Factory.create(:folder, :client => @client)
      @folder2 = Factory.create(:folder, :client => @client)
    end
    it "should have a folders attribute" do
      @client.should respond_to(:folders)
    end
    it "should have the right folders in right order" do
      @client.folders.should == [@folder1,@folder2]
    end
  end
end
