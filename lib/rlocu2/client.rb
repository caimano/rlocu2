module Rlocu2
  # Wrapper for the Locu API v 2.0
  #
  class Client
    include Venues

    attr_reader :api_key

    def initialize(options={})
      @api_key = options[:api_key] || Rlocu2.api_key
    end

    def connection
      params = {}
      params[:api_key] = @api_key if @api_key
      @connection ||= Faraday::Connection.new(:url => api_url, :params => params, :headers => default_headers) do |builder|
        @connection_middleware.each do |middleware|
          builder.use *middleware
        end
        builder.adapter Faraday.default_adapter
      end
    end

    def api_url
      'https://api.locu.com'
    end

    private

    def default_headers
      headers = {
          :accept =>  'application/json',
          :user_agent => 'Rlocu2 Ruby Gem'
      }
    end

  end
end