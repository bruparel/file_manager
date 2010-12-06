Given /^I have clients named (.+)$/ do |client_names|
  client_names.split(', ').each do |name|
    Factory.create(:client, :client_name => name)
  end
end

Given /^I have no clients$/ do
  Client.delete_all
end

Then /^I should have ([0-9]+) clients?$/ do |count|
  Client.count.should == count.to_i
end

Given /^I have an existing client record$/ do
  Factory.create(:client)
end
