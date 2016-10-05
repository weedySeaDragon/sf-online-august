Feature: As a restaurant owner
  in order to change my mind
  I need to be able to edit dishes.

  Background:
    Given I am logged in as a restaurant owner
    And the following dishes exist
      | dish_name | dish_desc       | dish_price |
      | Kebab     | Delicious kebab | 9000       |

  Scenario: Navigating to edit page
    Given I am on the "show" page for "Kebab"
    And I click the link "Edit"
    Then I should be on the "edit dish" page for "Kebab"