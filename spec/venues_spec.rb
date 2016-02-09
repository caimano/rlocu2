require 'spec_helper'
describe Rlocu2 do
  let(:client) do
    client = Rlocu2::Client.new(:api_key => API_KEY)
  end

  context 'Venues' do
    it 'should search a venue' do
      client
      p client
      params = Hash.new
      params['fields'] = ['name']
      params['queries'] = [{'menus' => {'$present' => true}}]
      response = client.venues_search(params)
      p response
      expect(1).to eq(1)
    end
  end

end