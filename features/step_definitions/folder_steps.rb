Then /^I should have ([0-9]+) folders?$/ do |count|
  Folder.count.should == count.to_i
end

And /^I have an existing client with a folder named "([^\"]*)"$/ do |folder_name|
  Factory.create(:folder, :name => folder_name)
end

When /^I select the (\d+)(?:st|nd|rd|th) folder$/ do |pos|
  within("form > ul > li:first-child > input") do
    check "folder1"
  end
end
