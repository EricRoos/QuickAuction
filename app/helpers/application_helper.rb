# frozen_string_literal: true

module ApplicationHelper
  def has_new_message?(user)
    return false if user.nil?

    user.notifications.unread.count.positive?
  end
end
