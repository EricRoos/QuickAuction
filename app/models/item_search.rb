# frozen_string_literal: true

class ItemSearch
  include ActiveModel::Model
  attr_accessor :query, :has_no_offers, :my_listings, :current_user, :include_expired, :is_ladder, :is_hardcore

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
      build_grouping
    ]
  end

  def base_scope
    base = AuctionItem.left_outer_joins(:auction_offers)
                      .select('auction_items.*, count(auction_offers.id) as offer_count')

    return base if ActiveRecord::Type::Boolean.new.cast(my_listings)

    join_sql = <<-SQL
      inner join moderation_items on moderation_items.moderatable_id = auction_items.id
        and moderatable_type='AuctionItem'
        and moderation_items.state in ('approved')
    SQL
    base.joins(join_sql)
  end

  def build_query(scope)
    scope = scope.where('lower(title) like ?', "%#{query.downcase}%") if query.present?
    scope = scope.where(user_id: current_user) if ActiveRecord::Type::Boolean.new.cast(my_listings)
    scope = scope.not_expired unless ActiveRecord::Type::Boolean.new.cast(include_expired)
    scope.where(
      is_hardcore: is_hardcore || false,
      is_ladder: is_ladder || false
    )
  end

  def build_sort(scope)
    scope.order(created_at: :asc)
  end

  def build_limit(scope)
    scope.limit(50)
  end

  def build_filter(scope)
    return scope.having('count(auction_offers.id) = 0') if ActiveRecord::Type::Boolean.new.cast(has_no_offers)

    scope
  end

  def build_grouping(scope)
    scope.group('auction_items.id')
  end
end
