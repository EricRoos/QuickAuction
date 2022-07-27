# frozen_string_literal: true

class InterestedPeopleController < ApplicationController
  skip_before_action :check_public_access_enabled
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized

  def create
    @interested_person = InterestedPerson.new(interested_person_params)
    @interested_person.save
    session[:subscribed_to_email] = true
    redirect_to root_path, notice: 'Thanks for subscribing'
  end

  protected

  def interested_person_params
    params.require(:interested_person).permit(:email)
  end
end
