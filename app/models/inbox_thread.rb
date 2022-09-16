# frozen_string_literal: true

class InboxThread
  include ActiveModel::Model

  attr_accessor :last_message_text, :notification_ids, :title, :key_value, :last_activity_at, :read_at

  def self.thread_data(key_name, recipient, additional_scope = {})
    Notification.connection.select_all(arel_for_thread(key_name, recipient,
                                                       additional_scope)).result.cast_values.map do |data|
      { key_value: data[1].first, notification_ids: data[0], last_activity_at: data[2], read_at: data[3] }
    end
  end

  def self.all(key_name, recipient, &block)
    thread_data = thread_data(key_name, recipient)
    last_notification_ids = thread_data.map { |t| t[:notification_ids].last }.compact

    message_map = message_map(last_notification_ids)

    thread_data.map do |t|
      message = message_map[t[:notification_ids].last]
      title = 'N/A'
      title = block.call(t) if block_given?
      read_at = nil
      read_at = t[:read_at].any?(&:nil?) ? nil : t[:read_at].last
      new(t.merge(last_message_text: message, title: title, read_at: read_at))
    end
  end

  def self.auction_threads_for(user)
    inbox_threads = InboxThread.all('auction_item_id', user)
    title_map = AuctionItem.where(id: inbox_threads.collect(&:key_value)).pluck(:id, :title).to_h
    inbox_threads.each do |inbox_thread|
      inbox_thread.title = "Auction for #{title_map[inbox_thread.key_value]}"
    end
  end

  def self.arel_for_thread(key_name, recipient, additional_scope)
    select_sql = <<-SQL
      array_agg(notifications.id) as id_list,
      array_agg(params -> :key_name) as param_list,
      max(notifications.created_at) as max_date,
      array_agg(notifications.read_at) as read_at_list
    SQL

    group_sql = 'params #>> :key_name'
    Notification
      .select(ActiveRecord::Base.sanitize_sql_array([select_sql, { key_name: key_name }]))
      .where(recipient: recipient)
      .where(additional_scope)
      .order('max_date desc')
      .group(ActiveRecord::Base.sanitize_sql_array([group_sql, { key_name: "{#{key_name}}" }]))
      .arel
  end
  class << self
    private

    def message_map(last_notification_ids)
      Notification.includes(:recipient).where(id: last_notification_ids).map do |notification|
        { notification.id => notification.to_notification.message }
      end.reduce(&:merge)
    end
  end
end
