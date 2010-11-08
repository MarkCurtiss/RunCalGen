Feature: creating a schedule
  As a runner
  It is important to have a training schedule
  So I'd like to be able to create one online

  Scenario: Create a 5k schedule for a beginning runner
    Given I am on the schedules page
    And I fill in "Sex" with "Male"
    And I fill in "Age" with "28"
    And I fill in "10k" time with "54:00"
    And I fill in "Race Type" with "5k"
    And I press "Submit"
    Then I should be on the schedule detail page for "5k training plan"
