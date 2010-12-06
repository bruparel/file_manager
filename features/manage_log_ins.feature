Feature: Sign in
  In order to get access to protected sections of the site
  A user
  Should be able to sign in with valid credentials

  Scenario: User does not have a valid account
    Given No user exists with a user name and password credentials of "goofy/dummy"
    When I try to sign in with a user name and password credentials of "goofy/dummy"
    Then I should see "Invalid login or password, or this account has been de-activated."
    And I should see the "Welcome" tab

  Scenario: User does have a valid account
    Given A user exists with a user name and password credentials of "goofy/dummy"
    When I try to sign in with a user name and password credentials of "goofy/dummy"
    Then I should see "Logged in successfully."
    And I should see the "Clients" tab
    When I follow "Logout"
    Then I should be logged out
