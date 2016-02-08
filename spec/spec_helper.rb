require 'bundler/setup'
Bundler.setup

require 'rlocu2'

RSpec.configure do |config|
  config.include WebMock::API
end


def rlocu2_get(path)
  stub_request(:get, Rlocu2.endpoint + path)
end
