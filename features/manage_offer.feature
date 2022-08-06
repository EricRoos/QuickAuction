Feature: Manage an auction

  @javascript
  Scenario: Accept an offer
    Given a "user" exists
    And the user has a "moderated auction item" known as "auction item"
    And the "auction item" has 1 "auction offer"
    And the "auction offer" has the attribute "description" with value of "My Offer"
    And the user is logged in
    And the user is on the page for the "auction item"
    When the user selects "accept" from "State event"
    And the user clicks on "Update Auction offer"
    Then the user should see "My Offer"
    And the user should see "accepted"

  @javascript
  Scenario: Reject an offer
    Given a "user" exists
    And the user has a "moderated auction item" known as "auction item"
    And the "auction item" has 1 "auction offer"
    And the "auction offer" has the attribute "description" with value of "My Offer"
    And the user is logged in
    And the user is on the page for the "auction item"
    When the user selects "reject" from "State event"
    And the user clicks on "Update Auction offer"
    Then the user should not see "My Offer"

  @javascript
  Scenario: Acknlowedge an offer
    Given a "user" exists
    And the user has a "moderated auction item" known as "auction item"
    And the "auction item" has 1 "auction offer"
    And the "auction offer" has the attribute "description" with value of "My Offer"
    And the user is logged in
    And the user is on the page for the "auction item"
    When the user selects "acknowledge" from "State event"
    And the user clicks on "Update Auction offer"
    Then the user should see "My Offer"
    And the user should see "acknowledged"

  @javascript
  Scenario: Viewing multiple offers
    Given a "user" exists
    And the user has a "moderated auction item" known as "auction item"
    And the "auction item" has 1 "accepted auction offer"
    And the "auction item" has 1 "auction offer"
    And the user is logged in
    And the user is on the page for the "auction item"
    Then the user should see "Offered By" within the "Current accepted offer" section
    Then the user should see "Offered By" within the "Offer in consideration" section


  @javascript
  Scenario: Accepting another offer
    Given a "user" exists
    And the user has a "moderated auction item" known as "auction item"
    And the "auction item" has 1 "accepted auction offer"
    And the "auction item" has 1 "auction offer"
    And the "auction offer" has the attribute "description" with value of "next to accept"
    And the user is logged in
    And the user is on the page for the "auction item"
    When the user selects "accept" from "State event" within the "Offer in consideration" section
    And the user clicks on "Update Auction offer" within "Offer in consideration"
    Then the user should see "next to accept" within the "Current accepted offer" section
    And the user should see "accepted" within the "Current accepted offer" section
    And the user should see "No offers under consideration" within the "Offer in consideration" section