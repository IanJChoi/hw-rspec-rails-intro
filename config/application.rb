require File.expand_path('boot', __dir__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Rottenpotatoes
  class Application < Rails::Application

    config.encoding = 'utf-8'

    config.filter_parameters += [
      :password,
      :api_key,
      :token
    ]

    config.assets.version = '1.0'

    config.active_support.escape_html_entities_in_json = true

    config.active_support.cache_format_version = 7.1

  end
end
