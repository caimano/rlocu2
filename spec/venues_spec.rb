require 'spec_helper'
describe Rlocu2 do
  let(:client) do
    client = Rlocu2::Client.new(:api_key => API_KEY)
  end

  context 'Venues' do
    it 'should search a venue' do

      params = Hash.new
      params['fields'] = ['name']
      params['queries'] = [{'menus' => {'$present' => true}}]
      response = client.venues_search(params)

      expect(response['status']).to eq('success')
      expect(response['http_status']).to eq(200)
      expect(response['venues']).to be_an_instance_of(Array)
    end
  end

end