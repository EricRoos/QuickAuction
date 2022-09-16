# frozen_string_literal: true

module AuctionItemsHelper
  def table(auction_items)
    data = auction_items.map do |item|
      item_to_table_data(item)
    end
    render(TableComponent.new(headers: table_headers, data: data))
  end

  def search_form(auction_item)
    render ItemSearchFormComponent.new(model: auction_item)
  end

  def new_auction_wizard(auction_item, current_step = 0)
    ordered_partials = [
      'auction_items/form_steps/find_item',
      'auction_items/form_steps/item_info',
      'auction_items/form_steps/screenshot',
      'auction_items/form_steps/confirm'
    ]
    render partial: ordered_partials[current_step - 1], locals: { auction_item: auction_item }
  end

  protected

  def item_to_table_data(item)
    {
      elements: [
        item.title,
        item.description,
        item.offer_count,
        link_to('Show', url_for(item))
      ],
      options: {
        disabled: item.expired?
      }
    }
  end

  def table_headers
    headers = %w[
      Title
      Description
      Offers
    ]
    headers << ''
    headers
  end
end
