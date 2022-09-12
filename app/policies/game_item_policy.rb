# frozen_string_literal: true

class GameItemPolicy < ApplicationPolicy
  def index?
    @user.present?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
