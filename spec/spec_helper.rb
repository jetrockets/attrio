require 'rubygems'

$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'attrio'
require 'rspec'
require 'webmock/rspec'

require 'coveralls'
Coveralls.wear!

Class.class_eval do
  def const_missing(name)
    Attrio::AttributesParser.cast_type(name) || super
  end
end

RSpec.configure do |config|
  config.include WebMock::API
  config.order = :rand
  config.color_enabled = true
  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.before(:each) do
    WebMock.reset!
  end
  config.after(:each) do
    WebMock.reset!
  end
end