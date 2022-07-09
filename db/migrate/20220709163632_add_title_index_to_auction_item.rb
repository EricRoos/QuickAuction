class AddTitleIndexToAuctionItem < ActiveRecord::Migration[7.0]
  def change
    add_index :auction_items, :title
  end
end
