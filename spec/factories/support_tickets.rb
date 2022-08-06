# frozen_string_literal: true

FactoryBot.define do
  factory :support_ticket do
    type { '' }
    user { 'MyString' }
    description { 'MyString' }
  end
end
