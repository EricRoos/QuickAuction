# frozen_string_literal: true

class SupportTicketsController < ApplicationController
  skip_before_action :check_beta_access
  skip_after_action :verify_authorized

  def new
    @support_ticket = SupportTicket.new(support_ticket_params)
  end

  def create
    @support_ticket = current_user.support_tickets.create(support_ticket_params)
  end

  protected

  def support_ticket_params
    return {} unless params[:support_ticket].present?

    params.require(:support_ticket).permit(:type, :description)
  end
end
