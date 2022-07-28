require_relative "boot"
require 'rack/throttle'

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InstaAuction
  class Application < Rails::Application
    config.exceptions_app = self.routes
    unless Rails.env.test?
      rules = [
        { method: "POST", path: "/interested_people", limit: 3, time_window: :hour },
      ]
      ip_whitelist = []
      default = 10
      config.middleware.use Rack::Throttle::Rules, rules: rules, ip_whitelist: ip_whitelist, default: default
    end

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
