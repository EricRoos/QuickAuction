# frozen_string_literal: true

require 'net/http'

class ZeptoTemplateMailer
  class << self
    def send(template_id, email, _options = {})
      return unless zepto_enabled?

      zepto_request({
                      mail_template_key: template_id,
                      bounce_address: 'bounce@bounce.instaauction.app',
                      from: from_details,
                      to: [
                        {
                          email_address: {
                            address: email
                          }
                        }
                      ]
                    })
    end

    private

    def from_details
      {
        address: 'noreply@instaauction.app',
        name: 'InstaAuction'
      }
    end

    def zepto_enabled?
      Flipper.enabled?(:zepto_mail) &&
        !Rails.env.test? &&
        ENV['ZEPTO_KEY'].present?
    end

    def zepto_request(body)
      uri = URI('https://api.zeptomail.com/v1.1/email/template')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
      req['Authorization'] = ENV.fetch('ZEPTO_KEY', nil)
      req.body = body.to_json
      http.request(req)
    end
  end
end
