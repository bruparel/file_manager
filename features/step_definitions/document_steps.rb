And /^a document status record exists$/ do
  Factory.create(:document_status)
end
When /^I attach an image to the documents field$/ do
  full_file_path = File.join(Rails.root, 'public/images/br.png')
  content_type = File.new(full_file_path).content_type
  attach_file "Document", full_file_path, content_type
end

Then /^I should have ([0-9]+) documents?$/ do |count|
  Document.count.should == count.to_i
end

Given /^I have an existing document within a folder within a client$/ do
  Factory.create(:document)
end

