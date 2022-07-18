# frozen_string_literal: true

FactoryBot.define do
  factory :moderation_item do
    moderatable { nil }
    state { 'MyString' }
  end
end
