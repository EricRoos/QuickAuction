# frozen_string_literal: true

class ItemSearchFormComponent < ViewComponent::Base
  def initialize(model:)
    @model = model
  end
end
