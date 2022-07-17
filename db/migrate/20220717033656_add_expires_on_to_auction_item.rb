class AddExpiresOnToAuctionItem < ActiveRecord::Migration[7.0]
  def change
    add_column :auction_items, :expires_on, :datetime
    add_index :auction_items, :expires_on
  end
end
