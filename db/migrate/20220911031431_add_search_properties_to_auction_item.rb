class AddSearchPropertiesToAuctionItem < ActiveRecord::Migration[7.0]
  def change
    add_column :auction_items, :region_cd, :string, default: 'us'
    add_column :auction_items, :game_cd, :string, default: 'diablo_2r'
    add_column :auction_items, :is_ladder, :boolean, default: false
    add_column :auction_items, :is_hardcore, :boolean, default: false

    add_index :auction_items, [:region_cd, :is_ladder, :is_hardcore], name: 'region_ladder_hardcore_idx'
  end
end
