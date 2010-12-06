Given /^I have base_folders? called (.+)$/ do |names|
  names.split(', ').each do |name|
    BaseFolder.create!(:name => name)
  end
end

Then /^I should have ([0-9]+) base folders?$/ do |count|       ""
  BaseFolder.count.should == count.to_i
end
