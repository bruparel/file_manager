Given /^I am signed up as "(.*)\/(.*)"$/ do |email, password|
  user = Factory :lead_user,
    :email                    => email,
    :password                 => password,
    :password_confirmation    => password
end

When /^I log in as "(.*)\/(.*)"$/ do |email,password|
  visit login_url
  fill_in "Email", :with => email
  fill_in "Password", :with => password
  click_button "Log in"
end

Then /^I should be logged in$/ do
  response.should contain("Logged in successfully.")
end

When /^I log out$/ do
  visit logout_url
end

