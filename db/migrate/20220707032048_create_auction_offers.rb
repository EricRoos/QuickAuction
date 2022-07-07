class CreateAuctionOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :auction_offers do |t|
      t.references :auction_item, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
