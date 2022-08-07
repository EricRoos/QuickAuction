ActiveAdmin.register SupportTicket do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :type, :user, :description
  #
  # or
  #
  # permit_params do
  #   permitted = [:type, :user, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    selectable_column
    column :type
    column :description
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :type
      row 'user' do |ticket|
        link_to ticket.user.email, url_for([:admin,ticket.user])
      end
      row :description
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
 
end
