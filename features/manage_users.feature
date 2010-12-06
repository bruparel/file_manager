Feature: Manage user accounts
  In order to correctly manage internal and external user accounts
  As an Administrator
  I want to test that the external users are always assigned a client

  Scenario: Create a new internal user - admin, lead, or staff - happy path
    Given I have no users
    And I have an existing Leader role
    And I am logged in as admin
    And I go to the list of users
    When I follow "New"
    And I fill in "Username" with "lead_user"
    And I fill in "Display Name" with "Lead User"
    And I fill in "Email Address" with "lead@ssrxgrp.com"
    And I fill in "Password" with "dummy"
    And I fill in "Confirm Password" with "dummy"
    And I select "Leader" from "Role"
    And I press "Submit"
    Then I should see "User account created and is ready for use."
    And I should have 2 users
    And the "Users" tab should be active

  Scenario: Create a new internal user - admin, lead, or staff - unhappy path
    Given I have no users
    And I have an existing Leader role
    And I have an existing client record
    And I am logged in as admin
    And I go to the list of users
    When I follow "New"
    And I fill in "Username" with "lead_user"
    And I fill in "Display Name" with "Lead User"
    And I fill in "Email Address" with "lead@ssrxgrp.com"
    And I fill in "Password" with "dummy"
    And I fill in "Confirm Password" with "dummy"
    And I select "Leader" from "Role"
    And I select "Super Group of Companies" from "Client"
    And I press "Submit"
    Then I should see "cannot assign an internal user to a client"
    And I should have 1 user
    And the "Users" tab should be active

  Scenario: Create a new external user - happy path
    Given I have no users
    And I have an existing External user role
    And I have an existing client record
    And I am logged in as admin
    And I go to the list of users
    When I follow "New"
    And I fill in "Username" with "external_user"
    And I fill in "Display Name" with "External User"
    And I fill in "Email Address" with "external@example.com"
    And I fill in "Password" with "dummy"
    And I fill in "Confirm Password" with "dummy"
    And I select "External Client" from "Role"
    And I select "Super Group of Companies" from "Client"
    And I press "Submit"
    Then I should see "User account created and is ready for use."
    And I should have 2 users
    And the "Users" tab should be active

  Scenario: Create a new external user - unhappy path
    Given I have no users
    And I have an existing External user role
    And I am logged in as admin
    And I go to the list of users
    When I follow "New"
    And I fill in "Username" with "external_user"
    And I fill in "Display Name" with "External User"
    And I fill in "Email Address" with "external@example.com"
    And I fill in "Password" with "dummy"
    And I fill in "Confirm Password" with "dummy"
    And I select "External Client" from "Role"
    And I press "Submit"
    Then I should see "must assign an external client to this user"
    And I should have 1 user
    And the "Users" tab should be active

  Scenario: Edit an existing user record - happy path
    Given I am logged in as admin
    When I go to the list of users
    Then I should see "admin"
    When I follow "Edit"
    And I fill in "Username" with "superadmin"
    And I press "Submit"
    Then I should see "User data was successfully updated"
    And I should see "superadmin"
    And the "Users" tab should be active

  Scenario: Edit an existing user record - unhappy path
    Given I am logged in as admin
    When I go to the list of users
    Then I should see "admin"
    When I follow "Edit"
    And I fill in "Password" with "goofy"
    And I fill in "Confirm Password" with "mickey"
    And I press "Submit"
    Then I should see "doesn't match confirmation"
    And the "Users" tab should be active
