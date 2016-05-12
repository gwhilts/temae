FactoryGirl.define do
  factory :user do
    email    'ulee@user.edu'
    password 'secret123'
    password_confirmation 'secret123'
  end
end
