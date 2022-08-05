ActiveAdmin.register Blog do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :published, :title, :subtitle, :abstract, :content_text
  form do |f|
    f.inputs 'Blog' do
      f.input :title
      f.input :subtitle
      f.input :abstract, as: :text
      f.input :content_text, as: :quill_editor
      f.input :published, as: :boolean
    end
    f.actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:published, :title, :subtitle, :abstract]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
