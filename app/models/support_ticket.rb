# frozen_string_literal: true

class SupportTicket < ApplicationRecord
  include StateMachine::SupportTicket

  belongs_to :user
end

require_dependency 'support_ticket/request_beta_access'
