Given /^I am logged in as admin$/ do
  # create admin user with a factory and log him in using webrat
  Factory.create(:admin_user)           # creates the admin user with its role (both)
  visit login_url
  fill_in "Username", :with => 'system'
  fill_in "Password", :with => 'important'
  click_button "Log in"
end

When /^I view the home page$/ do
  # do nothing here because you are already on "home page"
end

Then /^I should see the "([^\"]*)" tab$/ do |text|
  response.should contain(text)
end

Then /^I should not see the "([^\"]*)" tab$/ do |text|
  response.should_not contain(text)
end

Given /^I am logged in as leader$/ do
  # create lead user with a factory and log him in using webrat
  Factory.create(:lead_user)           # creates the lead user with its role (both)
  visit login_url
  fill_in "Username", :with => 'lead'
  fill_in "Password", :with => 'lead'
  click_button "Log in"
end

Given /^I am not logged in$/ do
  visit root_url
end

Given /^I am logged in as an external client user$/ do
  # Need to clean up the Roles table since login_hooks.rb
  # populates eclient role which will again be populated
  # by the :eclient_user factory thereby creating a problem
  Role.delete_all
  Factory.create(:eclient_user)
  visit login_url
  fill_in "Username", :with => 'external'
  fill_in "Password", :with => 'external'
  click_button "Log in"
end

And /^the "([^\"]*)" tab should be active$/ do |current_tab|
  response.should have_selector("#main-navigation li.active" , :content => current_tab )
end

Then /^I should be logged out$/ do
  response.should contain("Welcome")
end
