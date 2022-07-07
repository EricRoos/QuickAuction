# frozen_string_literal: true

FactoryBot.define do
  factory :auction_item do
    user
    title { 'MyString' }
    description { 'MyText' }
  end
end
