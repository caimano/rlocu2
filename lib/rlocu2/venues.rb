module Rlocu2

  module Venues
    def venues_search(options={})
      options['api_key'] = @api_key if @api_key
      options['fields'] =  [ "name", "location", "contact", "external" ]
      options['venue_queries'] = [{ "name" => "bistro central parc",
                                      "location" => {
                                                        "geo" => {
                                                            "$in_lat_lng_radius" => [37.775002, -122.44428, 5000]
                                                        }
                                      }
                                  }]

      response = connection.post do |req|
        req.url "venue/search"
        req.body = options.to_json
      end

      p response
      return_error_or_body(response, response.body.response)
    end
  end

end
