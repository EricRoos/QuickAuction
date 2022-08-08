# frozen_string_literal: true

module StateMachine
  module SupportTicket
    extend ActiveSupport::Concern
    include Base

    included do
      state_machine :state, initial: :open do
        event :mark_in_progress do
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
