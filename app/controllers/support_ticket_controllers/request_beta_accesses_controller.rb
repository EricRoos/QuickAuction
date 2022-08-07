# frozen_string_literal: true

module SupportTicketControllers
  class RequestBetaAccessesController < ApplicationController
    skip_before_action :check_beta_access
    skip_after_action :verify_authorized
    def new
      @support_ticket = SupportTicket::RequestBetaAccess.new
    end

    def create
      @support_ticket = SupportTicket::RequestBetaAccess.create(support_ticket_params)
      if @support_ticket.persisted?
        redirect_to new_support_ticket_path, notice: 'Thanks for your inquiry.'
      else
        Rails.logger.debug(@support_ticket.errors.to_json)
        flash[:alert] = 'Something went wrong.'
        render :new
      end
    end

    protected

    def support_ticket_params
      params.require(required_param_key).permit(:description).merge(user: current_user)
    end

    def required_param_key
      :support_ticket_request_beta_access
    end
  end
end
