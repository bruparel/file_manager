Feature: Manage documents
  In order to manage documents for a given folder
  As a user - admin, leader, staff, or external
  I want to upload and download documents
  
  Scenario: Upload a new document in a folder with no other documents
    Given I have an existing client with a folder named "folder1"
    And a document status record exists
    And I am logged in as admin
    When I go to the list of clients
    And I follow "Set"
    Then I should see "Current client set to Super Group of Companies."
    And the "Folders" tab should be active
    And I should see "folder1"
    When I follow "Set"
    Then I should see "Current folder set to folder1"
    And the "Documents" tab should be active
    And I should have 0 documents
    When I follow "New"
    And I fill in "Title" with "Cucumber Story"
    And I fill in "Description" with "Featuring Asklak Hellesoy"
    And I select "Verified" from "Document Status"
    When I attach an image to the documents field
    And I press "Submit"
    Then I should see "Successfully created document."
    And I should have 1 document
    And the "Documents" tab should be active

  Scenario: Edit an existing document
    Given I have an existing document within a folder within a client
    And I am logged in as admin
    When I go to the list of clients
    And I follow "Set"
    Then I should see "Current client set to Super Group of Companies."
    And the "Folders" tab should be active
    And I should see "Referrals"
    When I follow "Set"
    Then I should see "Current folder set to Referrals"
    And the "Documents" tab should be active
    And I should see "Important Picture"
    And I should have 1 document
    When I follow "Upload"
    And I fill in "Title" with "Toy Story"
    And I fill in "Description" with "Steve Jobs - Pixar Studios"
    And I select "Verified" from "Document Status"
    When I attach an image to the documents field
    And I press "Submit"
    Then I should see "Successfully updated document."
    And I should see "Toy Story"
    And I should have 1 document
    And the "Documents" tab should be active
