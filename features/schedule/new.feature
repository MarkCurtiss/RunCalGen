Feature: creating a schedule
  As a runner
  It is important to have a training schedule
  So I'd like to be able to create one online

  Scenario: Create a 5k schedule
    Given I am on the new_schedule page
    And it is '2010-07-01'
    And I select "5k" from "Race Type"
    And I fill in "datepicker" with "2010-12-05"
    And I choose "Saturday"
    And I press "Download Schedule"
    Then I should download a file called '5k_schedule_for_2010-12-05.ics'
