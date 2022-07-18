ActiveAdmin.register ModerationItem do

  controller do
    include ActiveStorage::SetCurrent
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :moderatable_type, :moderatable_id, :state
  #
  # or
  #
  # permit_params do
  #   permitted = [:moderatable_type, :moderatable_id, :state]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    selectable_column
    column "Status", :state
    column "Created at", :created_at
    column "Description" do |item|
      div item.moderatable.title if item.moderatable.is_a?(AuctionItem)
      div item.moderatable.description if item.moderatable.is_a?(AuctionItem)
      img src: (item.moderatable.auction_image.url rescue nil)
    end
  end

  batch_action :approve do |ids|
    batch_action_collection.find(ids).each do |item|
      item.approve
      redirect_to collection_path, alert: 'Items have been approved'
    end
  end
end
