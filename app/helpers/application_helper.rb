# frozen_string_literal: true

module ApplicationHelper
  def new_message?(user)
    return false if user.nil?

    user.notifications.unread.count.positive?
  end
end
