Given /^No user exists with a user name and password credentials of "(.*)\/(.*)"$/ do |email,password|
  assert_nil User.find_by_email(email)
end

Given /^A user exists with a email and password credentials of "(.*)\/(.*)"$/ do |email,password|
  Factory.create(:lead_user,:email => email,:password => password,:password_confirmation => password)
end


When /^I try to sign in with a email and password credentials of "(.*)\/(.*)"$/ do |email,password|
  visit login_url
  fill_in "Email", :with => email
  fill_in "Password", :with => password
  click_button "Log in"
end

