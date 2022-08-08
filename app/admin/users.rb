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

  member_action :enable_feature, method: :post do
    Flipper.enable_actor params[:feature], resource
    redirect_to resource_path, notice: "enabled #{params[:feature]} for user##{resource.id}"
  end

  member_action :disable_feature, method: :post  do
    Flipper.disable_actor params[:feature], resource
    redirect_to resource_path, notice: "disabled #{params[:feature]} for user##{resource.id}"
  end

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
    panel "Features" do
      table_for Flipper.features do
        column :name
        column :state do |feature|
          Flipper.enabled? feature.name, user
        end
        column '' do |feature|
          span do
            button_to('Enable', enable_feature_admin_user_path(user, feature: feature))
          end
          span do
            button_to('Disable', disable_feature_admin_user_path(user, feature: feature))
          end
        end
      end
    end
  end
end
