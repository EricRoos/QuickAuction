# frozen_string_literal: true

class ItemSearch
  include ActiveModel::Model
  attr_accessor :query, :has_no_offers, :my_listings, :current_user, :include_expired

  def call
    pipeline.inject(base_scope) { |scope, operation| send(operation, scope) }
  end

  protected

  def pipeline
    %i[
      build_query
      build_filter
      build_sort
      build_limit
    ]
  end

  def base_scope
    AuctionItem.left_outer_joins(:auction_offers)
               .select('auction_items.*, count(auction_offers.id) as offer_count')
               .group(:id)
  end

  def build_query(scope)
    scope = scope.where('lower(title) like ?', "%#{query.downcase}%") if query.present?
    scope = scope.where(user_id: current_user) if ActiveRecord::Type::Boolean.new.cast(my_listings)
    scope = scope.not_expired unless include_expired
    scope
  end

  def build_sort(scope)
    scope.order(created_at: :desc)
  end

  def build_limit(scope)
    scope.limit(50)
  end

  def build_filter(scope)
    return scope.having('count(auction_offers.id) = 0') if ActiveRecord::Type::Boolean.new.cast(has_no_offers)

    scope
  end
end
