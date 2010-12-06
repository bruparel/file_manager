Feature: Password reset
  In order to comply with the security policies
  A user
  Should be able to reset his password

  Scenario: User is signed up and updates his password
    Given I am signed up as "some_name/password"
    And I log in as "some_name/password"
    And I click on the change password link
    And I update my password with "new_password/new_password"
    Then I should see "Password successfully updated."
    When I log out
    Then I should be logged out
    When I log back in as "some_name/new_password"
    Then I should be logged in
