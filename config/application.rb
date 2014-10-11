require File.expand_path('../boot', __FILE__)
require 'dotenv'
Dotenv.load

%w(
  action_controller
  action_mailer
  active_resource
  rails/test_unit
).each do |framework|
  begin
    require "#{framework}/railtie"
  rescue LoadError
  end
end

Bundler.require(*Rails.groups)

module Apuntanotas
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
