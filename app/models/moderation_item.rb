# frozen_string_literal: true

class ModerationItem < ApplicationRecord
  belongs_to :moderatable, polymorphic: true
  scope :for, ->(moderatable) { where(moderatable: moderatable) }

  state_machine :state, initial: :waiting_for_review do
    after_transition do |item, _transition|
      item.moderatable.perform_after_moderation if item.moderatable.respond_to?(:perform_after_moderation)
    end
    event :approve do
      transition any => :approved
    end

    event :reject do
      transition any => :reject
    end
  end
end
