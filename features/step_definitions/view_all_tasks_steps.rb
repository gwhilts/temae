Given(/^an authenticated new user, Fred$/) do
  # Create user
  email = 'fred@fred.net'
  password = 'secretpass'
  User.new(email: email, password: password, password_confirmation: password).save!
  
  # Sign-in
  visit '/users/sign_in'
  fill_in "user_email", with: email
  fill_in "user_password", with: password
  click_button "Log in"
end

Given(/^Fred has several tasks$/) do

  user = User.find_by(email: 'fred@fred.net')

  tasks = [{ name:       'Wash Car',
             start:      Time.utc(2016, 5, 7),
             due:        Time.utc(2016, 5, 9),
             context:    user.contexts.third,
             user:       user
           },
           { name:       'Pick up library book',
             start:      Time.utc(2016, 5, 7),
             due:        Time.utc(2016, 5, 10),
             context:    user.contexts.third,
             user:       user
           },
           { name:       'Return library book',
             start:      Time.utc(2016, 5, 11),
             due:        Time.utc(2016, 5, 24),
             context:    user.contexts.second,
             user:       user
           },
           { name:       'Submit Pull Request',
             start:      Time.utc(2016, 5, 8),
             due:        Time.utc(2016, 5, 8),
             context:    user.contexts.second,
             user:       user
           },
           { name:       'Fix Issue #382',
             start:      Time.utc(2016, 5, 7),
             due:        Time.utc(2016, 5, 7),
             context:    user.contexts.first,
             user:       user
           },
           { name:       'Replace Furnace Filter',
             start:      Time.utc(2016, 5, 1),
             due:        Time.utc(2016, 5, 31),
             context:    user.contexts.second,
             user:       user
           }
          ]
   tasks.each do |task|
     Task.create! task
   end

end

When(/^I visit the homepage$/) do
  visit root_path
end

Then(/^I should see a list of all my tasks$/) do
  expect(page).to have_content('Wash Car')
  expect(page).to have_content('Replace Furnace Filter')
  expect(page).to have_selector('.task', count: 6)
end

Then(/^they are grouped by context$/) do
  expect(page).to have_selector('.context .task')
end

# Then(/^they sorted by due date, start date$/) do
#   pending # Write code here that turns the phrase above into concrete actions
# end

