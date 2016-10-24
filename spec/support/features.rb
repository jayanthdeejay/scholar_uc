# frozen_string_literal: true
# spec/support/features.rb
require File.expand_path('../features/session_helpers', __FILE__)
require File.expand_path('../locations', __FILE__)
require File.expand_path('../proxies', __FILE__)
require File.expand_path('../selectors', __FILE__)

RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
end
