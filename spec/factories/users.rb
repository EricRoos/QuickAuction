FactoryBot.define do
  factory :user do
    sequence(:email, User.count + 1 ) { |n| "user_#{n}@test.com" }
    password { 'test123456' }
  end
end
