# frozen_string_literal: true

class SupportTicket < ApplicationRecord
  include StateMachine::SupportTicket

  belongs_to :user

  def supports_description?
    true
  end
end

require_dependency 'support_ticket/request_beta_access'
require_dependency 'support_ticket/general_support'
