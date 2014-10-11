require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'dotenv'
Dotenv.load

Bundler.require(*Rails.groups)

module Apuntanotas
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
