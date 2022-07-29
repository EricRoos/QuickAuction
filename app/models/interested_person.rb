# frozen_string_literal: true

require Rails.root.join('lib', 'zepto_template_mailer')

class InterestedPerson < ApplicationRecord
  validates_uniqueness_of :email
  validates_presence_of :email
  after_create :send_welcome_email

  def send_welcome_email
    ZeptoTemplateMailer.send(
      ENV.fetch('ZEPTO_WELCOME_MAILER_KEY', nil),
      email
    ).is_a?(Net::HTTPCreated)
  end
end
