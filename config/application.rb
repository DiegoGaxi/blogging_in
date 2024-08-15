require_relative "boot"
require "rails/all"
require 'pagy'
require 'pagy/extras/bootstrap'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BloggingIn
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.time_zone = 'Mexico City'
    config.assets.enabled = true
    Rails.application.config.active_storage.content_types_allowed_inline += ['image/webp']
    config.i18n.available_locales = %i[es-MX en]
    config.i18n.default_locale = :"es-MX"

    config.eager_load_paths += %W[#{config.root}/lib/utils]
    config.active_record.yaml_column_permitted_classes = [Symbol, Date, Time, ActiveSupport::TimeWithZone, ActiveSupport::TimeZone, ActiveSupport::HashWithIndifferentAccess, BigDecimal]

    config.action_view.field_error_proc = proc { |html_tag, _instance| html_tag.html_safe }

    config.before_configuration do
      if Rails.env.development? || Rails.env.test?
        env_file = File.join(Rails.root, 'config', 'environments', "#{::Rails.env}_env.yml")
        variables = YAML.safe_load(File.open(env_file))
        if File.exist?(env_file) && variables
          variables.each do |key, value|
            ENV[key.to_s] = value
          end
        end
      end
    end

    # config.middleware.insert_after ActionDispatch::Static, Rack::Deflater

    # config.generators do |g|
    #   g.test_framework :rspec
    # end
  end
end
