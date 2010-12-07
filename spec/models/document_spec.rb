require 'spec_helper'
describe Document do

  before(:each) do
    @folder = Factory.create(:folder)
    @attr   = Factory.attributes_for(:document)
  end

  it "should create a new instance with valid attributes" do
    @folder.documents.create!(@attr)
  end

  describe "Folder association" do
    before(:each) do
      @document = @folder.documents.create(@attr)
    end
    it "should have a folder attribute" do
      @document.should respond_to(:folder)
    end
    it "should have the right associated folder" do
      @document.folder_id.should == @folder.id
      @document.folder.should == @folder
    end
  end

  describe "validations" do
    it "should have a folder id" do
      Document.new(@attr).should_not be_valid
    end
    it "should require a nonblank title" do
      @folder.documents.build(:title => "    ").should_not be_valid
    end
  end

  describe "Document status association" do
    before(:each) do
      @document_status = Factory.create(:document_status)
      document = Factory.build(:document)
      @document = @document_status.documents.create(document)
    end
    it "should have a document status attribute" do
      @document.should respond_to(:document_status)
    end
    it "should have the right document status value" do
      @document.document_status.should == @document_status
    end
  end

end
