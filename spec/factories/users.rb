# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email, begin
      (User.count + 1)
    rescue StandardError
      1
    end) { |n| "user_#{n}@test.com" }
    password { 'test123456' }
  end
end
