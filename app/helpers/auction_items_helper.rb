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

  protected

  def item_to_table_data(item)
    {
      elements: [
        item.title.to_s,
        item.description.to_s,
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
