Given /^I click on the change password link$/ do
  click_link "Change Password"
end

When /^I update my password with "(.*)\/(.*)"$/ do |password, new_password|
  fill_in "New Password", :with => password
  fill_in "Password Confirmation", :with => new_password
  click_button "Change Password"
end

When /^I log back in as "(.*)\/(.*)"$/ do |user_name,password|
  When %{I log in as "#{user_name}/#{password}"}
end