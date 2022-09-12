# frozen_string_literal: true

class GameItem < ApplicationRecord
  validates_uniqueness_of :name
end
