# frozen_string_literal: true

FactoryBot.define do
  factory :auction_item do
    user
    title { 'MyString' }
    description { 'MyText' }
  end

  factory :moderated_auction_item, parent: :auction_item do
    after(:create) do |object|
      object.moderation_item.approve
    end
  end
end
