Feature: Manage base_folders
  In order to provide a template of folders for the users
  As an Administrator
  I want to create and manage base folders

  Scenario: BaseFolders List
    Given I am logged in as admin
    And I have base_folders called folder1, folder2
    When I go to the list of base_folders
    Then I should see "folder1"
    And I should see "folder2"
    And I should have 2 base folders
  
