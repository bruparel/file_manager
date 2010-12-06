Feature: Control User Navigational Access
  In order to support role based user navigation
  users in different roles
  Will see only see the "Admin" tab if in admin role and will have an appropriate default tabs active

  Scenario: Admin user logs in
    Given I am logged in as admin
    When I view the home page
    Then the "Clients" tab should be active
    And I should see the "Admin" tab

  Scenario: Lead user logs in
    Given I am logged in as leader
    When I view the home page
    Then the "Clients" tab should be active
    And I should not see the "Admin" tab

  Scenario: Guest use accesses the site
    Given I am not logged in
    When I view the home page
    Then I should not see the "Admin" tab
    And I should see the "Welcome" tab

  Scenario: An External Client user logs in
    Given I am logged in as an external client user
    When I view the home page
    Then I should see the "Basic Info" tab
    And the "Welcome" tab should be active
    
