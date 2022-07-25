# frozen_string_literal: true

class InboxThread
  include ActiveModel::Model

  attr_accessor :last_message_text, :notification_ids, :title, :key_value, :last_activity_at

  def self.thread_data(key_name, recipient, additional_scope = {})
    select_sql = 'array_agg(notifications.id), array_agg(params -> :key_name), max(notifications.created_at) as max_date'
    group_sql = 'params #>> :key_name'
    base_arel = Notification
                .select(ActiveRecord::Base.sanitize_sql_array([select_sql, { key_name: key_name }]))
                .where(recipient: recipient)
                .where(additional_scope)
                .order('max_date desc')
                .group(ActiveRecord::Base.sanitize_sql_array([group_sql, { key_name: "{#{key_name}}" }]))
                .arel
    Notification.connection.select_all(base_arel).result.cast_values.map do |data|
      { key_value: data[1].first, notification_ids: data[0], last_activity: data[2] }
    end
  end

  def self.all(key_name, recipient, &block)
    thread_data = thread_data(key_name, recipient)
    last_notification_ids = thread_data.map { |t| t[:notification_ids].last }.compact

    message_map = Notification.includes(:recipient).where(id: last_notification_ids).map do |notification|
      { notification.id => notification.to_notification.message }
    end.reduce(&:merge)

    thread_data.map do |t|
      message = message_map[t[:notification_ids].last]
      title = 'N/A'
      title = block.call(t) if block_given?
      new(title: title, last_message_text: message, notification_ids: t[:notification_ids], key_value: t[:key_value],
          last_activity_at: t[:last_activity])
    end
  end

  def self.auction_threads_for(user)
    InboxThread.all('auction_item_id', user) do |data|
      "Auction ##{data[:key_value]}"
    end
  end
end
