require 'faraday'

directory = File.expand_path(File.dirname(__FILE__))

module Rlocu2
  class << self

    FIELDS = [:api_key ]
    attr_accessor(*FIELDS)

    def configure
      yield self
      true
    end

  end

  require 'rlocu2/venues'
  require 'rlocu2/client'
end