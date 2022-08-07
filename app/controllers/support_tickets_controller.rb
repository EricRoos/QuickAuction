# frozen_string_literal: true

class SupportTicketsController < ApplicationController
  skip_before_action :check_beta_access
  skip_after_action :verify_authorized

  def new
    @support_ticket = SupportTicket.new(support_ticket_params)
  end

  def create
    @support_ticket = SupportTicket.new(support_ticket_params)
    redirect_to(polymorphic_path(@support_ticket.class, action: :new))
  end

  protected

  def support_ticket_params
    return {} unless params[:support_ticket].present?

    params.require(:support_ticket).permit(:type)
  end
end
