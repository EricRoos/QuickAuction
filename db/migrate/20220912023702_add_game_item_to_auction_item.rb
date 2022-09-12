class AddGameItemToAuctionItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :auction_items, :game_item, null: false, foreign_key: true
  end
end
