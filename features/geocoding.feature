Feature: Geocoding restaurants

Background:
  Given the following restaurant exist
  | name |
  | McD  |

Scenario: Geocode restaurant
  Given I am on restaurant page for "McD"
  Then "McD" should have a latitude