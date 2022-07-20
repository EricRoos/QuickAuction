# frozen_string_literal: true

class AuctionOfferPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    @record.auction_item.moderation_item.approved?
  end

  def create?
    record.auction_item.user != user &&
      !record.auction_item.auction_offers.where(user: user).with_states(:accepted, :acknowledged).exists? &&
      !record.auction_item.expired?
  end

  def new?
    create?
  end

  def update?
    record.auction_item.user == user
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
