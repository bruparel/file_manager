require 'spec_helper'
describe Folder do

  before(:each) do
    @client = Factory.create(:client)
    @attr   = Factory.attributes_for(:folder)
  end

  it "should create a new instance with valid attributes" do
    @client.folders.create!(@attr)
  end

  describe "Client association" do
    before(:each) do
      @folder = @client.folders.create(@attr)
    end
    it "should have a client attribute" do
      @folder.should respond_to(:client)
    end
    it "should have the right associated client" do
      @folder.client_id.should == @client.id
      @folder.client.should == @client
    end
  end

  describe "validations" do
    it "should have a client id" do
      Folder.new(@attr).should_not be_valid
    end
    it "should require nonblank name" do
      @client.folders.build(:name => "     ").should_not be_valid
    end
  end

  describe "Document association" do
    it "document should belong to a folder" do
      Document.reflect_on_association(:folder).should_not be_nil
    end
    it "folder can have many documents" do
      folder = Factory.create(:folder)
      folder.documents << Factory.build(:document, :title => "Document 1")
      folder.documents << Factory.build(:document, :title => "Document 2")
      folder.should have(2).documents
    end
  end

end
