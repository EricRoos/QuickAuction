class AddMetaToSupportTicket < ActiveRecord::Migration[7.0]
  def change
    add_column :support_tickets, :meta, :jsonb, default: {}
  end
end
