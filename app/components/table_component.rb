# frozen_string_literal: true

class TableComponent < ViewComponent::Base
  def initialize(headers:, data:, condensed: false)
    super
    @headers = headers
    @data = data
    @condensed = condensed
  end

  def y_padding_class
    return 'py-1' if @condensed

    'py-4'
  end
end
