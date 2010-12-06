Given /^I have no users$/ do
  User.delete_all
end

And /^I have an existing Leader role$/ do
  Factory.create(:leader_role)
end

Then /^I should have ([0-9]+) users?$/ do |count|
  User.count.should == count.to_i
end

And /^I have an existing External user role$/ do
  # do nothing since login_hooks creates the external client role already
end
