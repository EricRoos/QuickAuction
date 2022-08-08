ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  show do
    default_main_content
    panel "Tickets" do
      table_for user.support_tickets do
        column :id
        column :type
        column :state
        column :description
        column :created_at
        column :updated_at
        column '' do |ticket|
          link_to 'View', admin_support_ticket_path(ticket)
        end
      end
    end
  end
end
