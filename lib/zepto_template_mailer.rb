# frozen_string_literal: true

require 'net/http'

class ZeptoTemplateMailer
  class << self
    def send(template_id, email, _options = {})
      return unless Flipper.enabled?(:zepto_mail)
      return if Rails.env.test?
      return unless ENV['ZEPTO_KEY'].present?

      uri = URI('https://api.zeptomail.com/v1.1/email/template')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
      req['Authorization'] = ENV.fetch('ZEPTO_KEY', nil)
      req.body = {
        mail_template_key: template_id,
        bounce_address: 'bounce@bounce.instaauction.app',
        from: {
          address: 'noreply@instaauction.app',
          name: 'InstaAuction'
        },
        to: [
          {
            email_address: {
              address: email
            }
          }
        ]
      }.to_json
      http.request(req)
    end
  end
end
