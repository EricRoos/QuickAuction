class AddStateToSupportTicket < ActiveRecord::Migration[7.0]
  def change
    add_column :support_tickets, :state, :string
    add_index :support_tickets, [:state, :created_at]
  end
end
