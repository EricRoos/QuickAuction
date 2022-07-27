require_relative "boot"
require 'rack/throttle'

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

class Rack::Throttle::RequestMethod < Rack::Throttle::Second
  def max_per_second(request = nil)
    return (options[:max_per_second] || options[:max] || 1) unless request
    if request.request_method == "POST"
      4
    else
      100
    end
  end
  alias_method :max_per_window, :max_per_second
end

module InstaAuction
  class Application < Rails::Application
    config.middleware.use Rack::Throttle::RequestMethod unless Rails.env.test?
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
