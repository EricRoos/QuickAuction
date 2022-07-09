class AddStateToAuctionOffer < ActiveRecord::Migration[7.0]
  def change
    add_column :auction_offers, :state, :string
  end
end
