# frozen_string_literal: true

class AuctionItemPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    return true if @record.user == @user

    @record.moderation_item.approved?
  end

  def create?
    return false unless @user.present?

    true
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    @record.user == @user
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
