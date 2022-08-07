class CreateSupportTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :support_tickets do |t|
      t.string :type
      t.references :user
      t.string :description

      t.timestamps
    end
  end
end
