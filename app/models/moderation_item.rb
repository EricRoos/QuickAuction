# frozen_string_literal: true

class ModerationItem < ApplicationRecord
  belongs_to :moderatable, polymorphic: true
  scope :for, ->(moderatable) { where(moderatable: moderatable) }

  state_machine :state, initial: :waiting_for_review do
    event :approve do
      transition any => :approved
    end

    event :reject do
      transition any => :reject
    end
  end
end
