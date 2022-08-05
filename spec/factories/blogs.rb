# frozen_string_literal: true

FactoryBot.define do
  factory :blog do
    title { 'MyString' }
    subtitle { 'MyString' }
    abstract { 'MyText' }
    published { false }
  end
end
