Feature: Subscribe user to the notification list

  @javascript
  Scenario: Logged in and no problems
    Given the user is on the "home" page
    When the user fills in "Email" with "me@me.com" within "hero"
    And the user clicks on "Notify me" within "hero"
    Then the user should see "Thanks for subscribing"


