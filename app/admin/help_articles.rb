ActiveAdmin.register HelpArticle do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title
  #
  # or
  #
  permit_params do
    [:title, :content, :content_text]
  end

  form do |f|
    f.inputs 'Help Article' do
      f.input :title
      f.input :content_text, as: :quill_editor
    end
    f.actions
  end
end
