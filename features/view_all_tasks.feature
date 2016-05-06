Feature: View All Tasks
  As an authenticated user,
  I want to see all my tasks,
  so I can get s*** done.

  The tasks in the list should be grouped by context
  and sorted by due date, then start date.

  I should see only my tasks.

  For each task I want to see its:

    - Name
    - Project
    - Context
    - Start Date
    - Due Date

  Background:
    Given an authenticated new user, Fred

  Scenario: Viewing all tasks
    Given Fred has several tasks
    When I visit the homepage
    Then I should see a list of all my tasks
    And they are grouped by context


