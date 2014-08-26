require 'rubygems'

$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'attrio'
require 'rspec'
require 'rspec/its'
require 'webmock/rspec'
require 'json'
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

  config.before(:each) do
    WebMock.reset!
  end
  config.after(:each) do
    WebMock.reset!
  end
end
