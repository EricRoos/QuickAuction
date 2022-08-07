ActiveAdmin.register SupportTicket do
  preserve_default_filters!
  filter :state, as: :select, collection: SupportTicket.state_machine.states.map(&:value)
  filter :type, as: :select, collection: SupportTicket.descendants.map(&:to_s)
  remove_filter :description
  remove_filter :updated_at
  remove_filter :user


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :state_event
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
    column 'state' do |ticket|
      ticket.human_state_name
    end
    column :description
    column :created_at
    column :updated_at
    actions
  end

  form title: 'Update ticket' do |f|
    panel 'Details' do
      attributes_table_for(f.object) do
        row :state
        row :type
        row :description
      end
    end
    inputs 'Update State' do
      input :state_event, as: :select, collection: f.object.available_transition_events
    end
    actions
    active_admin_comments_for(f.object)
  end 

  show do
    attributes_table do
      row :id
      row :type
      row 'state' do |ticket|
        ticket.human_state_name
      end
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
