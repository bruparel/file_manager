Feature: Manage clients
  In order to create the South Side File Manager Application
  as an administrator
  I want to create and manage clients
  
  Scenario: Clients List
    Given I am logged in as admin
    And I have clients named Client1, Client2
    When I go to the list of clients
    Then I should see "Client1"
    And I should see "Client2"
    And I should have 2 clients

  Scenario: Create valid Client
    Given I have no clients
    And I am logged in as admin
    And I go to the list of clients
    When I follow "New" 
    And I fill in "Client Name" with "Duper Group of Companies"
    And I fill in "Contact Name" with "Duper Man"
    And I fill in "Address1" with "2200 Main Street"
    And I fill in "City" with "Boston"
    And I select "Massachusetts" from "State"
    And I fill in "Zip" with "02115"
    And I fill in "Phone" with "111-111-1111"
    And I fill in "Mobile" with "222-222-2222"
    And I fill in "Fax" with "333-333-3333"
    And I fill in "Comment" with "This is a test client"
    And I select "Active" from "Client Status"
    And I press "Submit"
    Then I should see "Basic Info successfully saved. Please proceed to create folders to store documents."
    And I should have 1 client
    And the "Folders" tab should be active

  Scenario: User edits an existing client record
    Given I have an existing client record
    And I am logged in as admin
    And I go to the list of clients
    And I follow "Edit"
    Then the "Client Name" field should contain "Super Group of Companies"
    When I fill in "Client Name" with "Excellent Group"
    And I press "Submit"
    Then I should see "Client data was successfully updated."
    And I should see "Excellent Group"
    And the "Clients" tab should be active

  Scenario: User selects an existing client record and resets it
    Given I have an existing client record
    And I am logged in as admin
    When I go to the list of clients
    And I follow "Set"
    Then I should see "Current client set to Super Group of Companies."
    And the "Folders" tab should be active
    When I follow "Reset"
    Then I should see "Current client unset."
    And the "Clients" tab should be active
