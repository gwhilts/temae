Feature: Clean-up Completed Tasks
  As a user,
  I want to delete all my completed tasks,
  So I can keep my lists clean and manageable.

  Background:
    Given an authenticated new user, Fred

  Scenario: Delete all completed tasks.
    Given Fred has several tasks
    And some tasks are open
    And some tasks are complete 
    When Fred visits the homepage
    And Fred clicks the delete button
    Then Fred should see only incomplete tasks in the list of all tasks
