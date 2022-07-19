# frozen_string_literal: true

FactoryBot.define do
  factory :admin_user do
    sequence(:email, begin
      (User.count + 1)
    rescue StandardError
      1
    end) { |n| "admin_user_#{n}.#{SecureRandom.hex(4)}@test.com" }
    password { 'test123456' }
  end
end
