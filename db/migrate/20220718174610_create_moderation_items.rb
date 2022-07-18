class CreateModerationItems < ActiveRecord::Migration[7.0]
  def change
    create_table :moderation_items do |t|
      t.references :moderatable, polymorphic: true, null: false
      t.string :state

      t.timestamps
    end
  end
end
