Feature: Sign out
  In order to properly protect the site against unauthorized access
  A signed in user
  Should be able to sign out

    Scenario: User signs out
      Given I am signed up as "some_name/password"
      When I log in as "some_name/password"
      Then I should be logged in
      When I log out
      Then I should be logged out
