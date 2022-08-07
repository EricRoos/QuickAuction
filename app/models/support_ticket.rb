# frozen_string_literal: true

class SupportTicket < ApplicationRecord
  include StateMachine::SupportTicket

  belongs_to :user

  def supports_description?
    true
  end

  def self.available_for?(_user)
    true
  end

  def self.available_types_for(user)
    descendants.select { |d| d.available_for?(user) }.map(&:to_s)
  end
end

require_dependency 'support_ticket/request_beta_access'
require_dependency 'support_ticket/general_support'
