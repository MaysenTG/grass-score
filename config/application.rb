require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module GrassScore
  class Application < Rails::Application
    config.load_defaults 7.2

    config.autoload_lib(ignore: %w[assets tasks])

    config.autoload_paths += %W(#{config.root}/app/poros/finders)

    config.generators.system_tests = nil
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: false,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false
    end
  end
end
