# frozen_string_literal: true

class InboxController < ApplicationController
  skip_after_action :verify_authorized
  def index
    @inbox_threads = InboxThread.auction_threads_for(current_user)
    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(:thread_messages, partial: 'inbox/thread_messages')
      end
    end
  end

  def show
    @notification = Notification.find(params[:notification_id]).to_notification
  end
end
