ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
# require "authlogic/test_case" # include at the top of test_helper.rb
require 'shoulda'
require 'factory_girl'
require File.expand_path(File.dirname(__FILE__) + "/factories")

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  def show_response
    Dir.mkdir(File.join(Rails.root.to_s, 'tmp')) unless File.directory?(File.join(Rails.root.to_s,'tmp'))
    response_html = File.join(Rails.root.to_s, 'tmp', 'response.html')
    File.open(response_html,'w') { |f| f.write(@response.body) }
    system 'open ' + File.expand_path(response_html) rescue nil
  end

end

class ActionController::TestCase
  include Devise::TestHelpers
end

unless defined?(Test::Unit::AssertionFailedError)
  class Test::Unit::AssertionFailedError < ActiveSupport::TestCase::Assertion
  end
end
