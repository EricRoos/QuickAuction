# frozen_string_literal: true

class HelpArticle < ApplicationRecord
  has_rich_text :content

  # problems with quill make me do this
  def content_text=(body)
    content.body = body
  end

  def content_text
    content.to_s.gsub(%r{\A<div class="trix-content">(.*)</div>\z}m, '\1').strip.html_safe
  end
end
