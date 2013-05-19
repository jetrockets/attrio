# encoding: utf-8

module Attrio  
  module Version
    MAJOR = 0
    MINOR = 0
    PATCH = 1
    BUILD = nil

    STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join('.')
  end
end