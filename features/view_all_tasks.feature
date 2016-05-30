Feature: View Tasks
  As an authenticated user,
  I want to see all my tasks,
  so I can get s*** done.

  The tasks in the list should be grouped by context by default.

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
    When Fred visits the homepage
    Then Fred should see a list of all his tasks
    And they are grouped by context

  Scenario: Viewing tasks by a specific context

  Scenario: Viewing all tasks by project

  Scenario: Viewing tasks by a specific project

  Scenario: Delete all completed tasks.
    Given Fred has several tasks
    And some tasks are open
    And some tasks are complete 
    When Fred visits the homepage
    And Fred clicks the delete button
    Then Fred should see only incomplete tasks in the list of all tasks
