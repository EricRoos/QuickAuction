# frozen_string_literal: true

class InboxController < ApplicationController
  skip_after_action :verify_authorized
  def index
    @inbox_threads = InboxThread.auction_threads_for(current_user)
    @focused = @inbox_threads.detect { |t| t.key_value.to_s == params[:focused_id] }
    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(:thread_messages, partial: 'inbox/thread_messages')
      end
    end
  end

  def show
    return if fragment_exist?(cache_key)

    @notification = current_user.notifications.find(params[:notification_id])
  end

  private

  def cache_key
    [:notifications, params[:notification_id]]
  end
  helper_method :cache_key
end
