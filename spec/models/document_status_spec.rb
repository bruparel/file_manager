require 'spec_helper'
describe DocumentStatus do
  describe "validate name" do
    it "Document status cannot be saved without a name" do
      doc_stat = Factory.build(:document_status, :name => '')
      doc_stat.should have(1).error_on(:name)
      doc_stat.should_not be_valid
    end
    it "Document status should be valid with a name" do
      doc_stat = Factory.create(:document_status)
      doc_stat.should be_valid
    end
    it "Document status should enforce uniqueness constraint on name" do
      doc_stat1 = Factory.create(:document_status)
      doc_stat2 = Factory.build(:document_status, :name => doc_stat1.name)
      doc_stat2.should have(1).error_on(:name)
      doc_stat2.should_not be_valid
    end
  end
  describe "Document associations" do
    before(:each) do
      @doc_status = Factory.create(:document_status)
      @doc1 = Factory.create(:document, :document_status => @doc_status)
      @doc2 = Factory.create(:document, :document_status => @doc_status, :title => "Another title")
      @doc_status.should have(2).documents
    end
    it "should have a documents attribute" do
      @doc_status.should respond_to(:documents)
    end
  end
end
