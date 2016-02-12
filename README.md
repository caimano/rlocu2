# Rlocu2

Unoffical, and currently incomplete wrapper for the Locu API 2.0 (locu.com)

## Installation

Add this line to your application's Gemfile:

    gem 'rlocu2'

And then execute:

    $ bundle install

Or install it yourself:

    $ gem install rlocu2

## Usage

First initialize the client with YOUR API KEY:

    $ require 'rlocu2'
    $
    $ client = Rlocu2::Client.new(:api_key => YOUR_API_KEY)

Prepare Hash with params to send to Locu:

    $ params = Hash.new
    $ params['fields'] = ['name','location','contact']
    $ params['venue_queries'] = []
    $ params['venue_queries'] << { 'name' => 'bistro central parc' }

Make call:

    $ client.venues_search(params)

Response is an Array of Rlocu2::Venue objects

## Test - RSpec

If you want to donwload the repository and test-it remember to change the API KEY inside 'spec/configuration.rb'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-checkout`)
3. Commit your changes (`git commit -am 'Add features'`)
4. Push to the branch (`git push origin my-checkout`)
5. Create new Pull Request