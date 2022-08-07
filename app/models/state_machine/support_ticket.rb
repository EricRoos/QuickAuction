# frozen_string_literal: true

module StateMachine
  module SupportTicket
    extend ActiveSupport::Concern
    include Base

    included do
      after_create do
      end

      state_machine :state, initial: :open do
        after_transition do |ticket, _transition|
        end

        event :lock do
          transition open: :in_progress
        end

        event :resolve do
          transition %i[in_progress] => :resolved
        end

        event :close do
          transition %i[in_progress] => :closed
        end

        event :wont_do do
          transition %i[in_progress open] => :closed
        end
      end
    end
  end
end
