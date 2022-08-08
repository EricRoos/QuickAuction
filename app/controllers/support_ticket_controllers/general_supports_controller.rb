# frozen_string_literal: true

module SupportTicketControllers
  class GeneralSupportsController < ApplicationController
    skip_before_action :check_beta_access
    skip_after_action :verify_authorized
    def new
      @support_ticket = SupportTicket::GeneralSupport.new
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update('new_support_ticket', partial: 'form',
                                                                         locals: { support_ticket: @support_ticket })
        end
      end
    end

    def create
      @support_ticket = SupportTicket::GeneralSupport.new(support_ticket_params)
      respond_to do |format|
        partial = @support_ticket.save ? 'success' : 'error'

        format.turbo_stream do
          render turbo_stream: turbo_stream.update('new_support_ticket', partial: partial,
                                                                         locals: { support_ticket: @support_ticket })
        end
      end
    end

    protected

    def support_ticket_params
      params.require(required_param_key).permit(:description).merge(user: current_user)
    end

    def required_param_key
      :support_ticket_general_support
    end
  end
end
