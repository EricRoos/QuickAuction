# frozen_string_literal: true

module Moderatable
  extend ActiveSupport::Concern

  included do
    after_commit :create_moderation_item, on: :create
    has_one :moderation_item, as: :moderatable
  end

  class_methods do
    def after_moderation(method)
      define_method(:perform_after_moderation) do
        send(method)
      end
    end
  end

  protected

  def create_moderation_item
    ModerationItem.create(moderatable: self).tap do |moderation_item|
      moderation_item.approve if Flipper.enabled?(:auto_approve_moderations)
    end
  end
end
