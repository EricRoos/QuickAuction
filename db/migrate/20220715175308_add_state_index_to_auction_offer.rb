class AddStateIndexToAuctionOffer < ActiveRecord::Migration[7.0]
  def change
    add_index :auction_offers, :state
  end
end
