# frozen_string_literal: true

module StateMachine
  module Base
    extend ActiveSupport::Concern

    def available_transition_events
      state_paths.map(&:first).collect(&:event).uniq.map { |e| [self.class.human_state_event_name(e), e] }
    end
  end
end
