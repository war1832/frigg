FactoryGirl.define do
  factory :user do
    username   'User1'
    first_name 'Juan'
    last_name  'Perez'
    email      'user_1@frigg.com'
    password   'qwerty123'

    trait :user_2  do
      username   'User2'
      first_name 'Ruben'
      last_name  'Rada'
      email      'user_2@frigg.com'
      password   'qwerty123'
    end
  end

    factory :admin, class: User  do
      username  'Admin'
      email     'admin@frigg.com'
      password  'admin123'
      admin     true
    end
end
