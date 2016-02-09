module Rlocu2

  module Venues

    FIELDS = ['locu_id',
              'name',
              'short_name',
              'description',
              'website_url',
              'menu_url',
              'menu_items',
              'menus',
              'open_hours',
              'external',
              'redirected_from',
              'categories',
              'location',
              'contact',
              'locu', # pro account
              'delivery',
              'extended'
              #:media # pro account
    ].freeze

    def venues_search(params={})
      options={}
      options['api_key'] = @api_key if @api_key
      options['fields'] = Array.new
      if (params.has_key? 'fields') && params['fields'].is_a?(Array)
        params['fields'].each do |p|
          options['fields'] << p if FIELDS.include? p
        end
      end

      if (params.has_key? 'queries') && params['queries'].is_a?(Array)
        # TODO check possible queries
        options['venue_queries'] = params['queries']
      end

      response = connection.post do |req|
        req.url "venue/search"
        req.body = options.to_json
      end


      return_error_or_body(response, response.body)
    end
  end

end
