# frozen_string_literal: true

module AuctionItemsHelper
  def table(auction_items)
    headers = %w[
      Title
      Description
      Offers
    ]

    headers << '' # for action rows

    data = auction_items.map do |item|
      [
        item.title.to_s,
        item.description.to_s,
        item.offer_count,
        link_to('Show', url_for(item))
      ]
    end
    render(TableComponent.new(headers: headers, data: data))
  end
end
