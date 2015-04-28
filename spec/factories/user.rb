FactoryGirl.define do
  factory :user do
    username   'User1'
    first_name 'Juan'
    last_name  'Perez'
    email      'user_1@frigg.com'
    password   'qwerty123'
    password_confirmation 'qwerty123'
    confirmed_at Date.today

    trait :user_2  do
      username   'User2'
      first_name 'Ruben'
      last_name  'Rada'
      email      'user_2@frigg.com'
      password   'qwerty123'
      password_confirmation 'qwerty123'
      confirmed_at Date.today
    end
  end

  factory :admin, class: User  do
    username  'Admin'
    email     'admin@frigg.com'
    password  'admin123'
    password_confirmation 'admin123'
    admin     true
    confirmed_at Date.today
  end
end
