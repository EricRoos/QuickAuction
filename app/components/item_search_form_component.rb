# frozen_string_literal: true

class ItemSearchFormComponent < ViewComponent::Base
  def initialize(model:)
    super
    @model = model
  end
end
