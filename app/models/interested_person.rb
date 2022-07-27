# frozen_string_literal: true

class InterestedPerson < ApplicationRecord
  validates_uniqueness_of :email
end
