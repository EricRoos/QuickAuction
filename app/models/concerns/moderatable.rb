# frozen_string_literal: true

module Moderatable
  extend ActiveSupport::Concern

  included do
    after_commit :create_moderation_item, on: :create
    has_one :moderation_item, as: :moderatable
  end

  def moderation_approved?
    ModerationItem.for(self).exists?
  end

  protected

  def create_moderation_item
    ModerationItem.create(moderatable: self)
  end
end
