Rottenpotatoes::Application.configure do

  config.cache_classes = true

  config.eager_load = true

  config.consider_all_requests_local = false

  config.action_controller.perform_caching = true

  config.public_file_server.enabled =
    ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.js_compressor = :uglifier

  config.assets.compile = false

  config.assets.digest = true

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_level = :info

  config.logger = ActiveSupport::Logger.new(STDOUT)

end
