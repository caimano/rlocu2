require 'faraday'
require 'faraday_middleware'
require 'json'

directory = File.expand_path(File.dirname(__FILE__))

module Rlocu2
  class << self

    FIELDS = [:api_key,
              :connection_middleware]
    attr_accessor(*FIELDS)

    def configure
      yield self
      true
    end

  end

  require 'rlocu2/client/venues'
  require 'rlocu2/client'
  require 'rlocu2/objects'
end