# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end
    columns do
      column do
        panel "Users created today" do
          User.where("created_at >= ? ", Date.today).count
        end
      end
      column do
        panel "Quick Links" do
          ul do
            li link_to('Manage feature flags', '/flipper')
            li link_to('Moderation Queue', admin_moderation_items_path('q[state_equals]': 'waiting_for_review'))
          end
        end
      end
    end
  end
end
