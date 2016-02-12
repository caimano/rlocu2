module Rlocu2
  # Wrapper for the Locu API v 2.0
  #
  class Client
    attr_reader :api_key

    DEFAULT_CONNECTION_MIDDLEWARE = [
        Faraday::Request::UrlEncoded,
        FaradayMiddleware::ParseJson
    ]


    def initialize(options={})
      @api_key = options[:api_key] || Rlocu2.api_key
      @connection_middleware = options[:connection_middleware] || Rlocu2.connection_middleware || []
      @connection_middleware += DEFAULT_CONNECTION_MIDDLEWARE
    end

    def connection
      @connection ||= Faraday::Connection.new(:url => api_url, :headers => default_headers) do |builder|
        @connection_middleware.each do |middleware|
          builder.use *middleware
        end
        builder.adapter Faraday.default_adapter
      end
    end

    def api_url
      'https://api.locu.com/v2/'
    end

    def return_error_or_body(response, response_body, type)
      if response.status == 200
        # REMAP & PARSE Objects
        output = Hash.new
        output['status'] = response_body['status']
        output['http_status'] = response_body['http_status']
        if type == 'venues'
          output['venues'] = response_body['venues'].each.reduce([]) { |accum, venue| accum << Rlocu2::Venue.new(venue) }
        end
        output
      else
        raise Rlocu2::APIError.new(response.body)
      end
    end


    include Venues

    private

    def default_headers
      headers = {
          :accept =>  'application/json',
          :user_agent => 'Rlocu2 Ruby Gem'
      }
    end

  end




  class APIError < StandardError

    attr_reader :code
    attr_reader :status
    attr_reader :detail

    def initialize(response)
      @code     = response['http_status']
      @status   = response['errorType']
      @detail   = response['error']
    end

    def message
      "#{@status}: #{@detail} (#{@code})"
    end
    alias :to_s :message
  end


end