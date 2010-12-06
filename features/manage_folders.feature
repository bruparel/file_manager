Feature: Manage folders
  In order to manage folders for a given client
  As a leader
  I want to be able to create, read, update, and delete folders
  
  Scenario: Create a new folder - A client with no folders assigned
    Given I have base_folders called folder1, folder2
    And I have an existing client record
    And I am logged in as admin
    And I go to the list of clients
    And I follow "Set"
    Then I should see "Current client set to Super Group of Companies."
    And the "Folders" tab should be active
    And I should see "Please select from the base folders to start and then customize"
    Then I should see "folder1"
    Then I should see "folder2"
    And I should have 2 base folders

  Scenario:Create a new folder - A client with one folder assigned
    Given I am logged in as admin
    And I have an existing client with a folder named "folder1"
    When I go to the list of clients
    And I follow "Set"
    Then I should see "Current client set to Super Group of Companies."
    And the "Folders" tab should be active
    And I should have 1 folder
    And I should see "folder1"
    When I follow "New"
    And I fill in "Name" with "folder2"
    And I press "Submit"
    Then I should see "Successfully created folder."
    And I should have 2 folders
    And the "Folders" tab should be active

  Scenario: Create an existing folder - A client with one folder assigned
    Given I am logged in as admin
    And I have an existing client with a folder named "folder1"
    And I go to the list of clients
    And I follow "Set"
    Then I should see "Current client set to Super Group of Companies."
    And the "Folders" tab should be active
    And I should have 1 folder
    And I should see "folder1"
    When I follow "Edit"
    When I fill in "Name" with "folder2"
    And I press "Submit"
    Then I should see "Successfully updated folder."
    And I should see "folder2"
    And the "Folders" tab should be active

