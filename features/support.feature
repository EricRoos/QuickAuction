Feature: Create an auction
  @javascript
  Scenario: Requesting beta access
    Given a "user" exists
    And the user is logged in
    And the user is on the "support" page
    When the user selects "Request beta access" from "What can we help with?"
    And the user clicks on "Next"
    And the user fills in "Tell us a little bit about what got you intersted." with "idk, cool app"
    And the user clicks on "Send"
    Then the user should see "We'll let you know when your beta access is granted."

  @javascript
  Scenario: General support
    Given a "user" exists
    And the user is logged in
    And the user is on the "support" page
    When the user selects "General support" from "What can we help with?"
    And the user clicks on "Next"
    And the user fills in "Tell us what happened, more specifics the better" with "idk, cool app"
    And the user clicks on "Send"
    Then the user should see "thanks for your ticket"


