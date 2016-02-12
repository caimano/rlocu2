require 'spec_helper'
describe Rlocu2 do
  let(:client) do
    client = Rlocu2::Client.new(:api_key => API_KEY)
  end

  context 'Venues' do

    it 'Querying for venues by name' do

      params = Hash.new
      params['fields'] = ['name','location','contact']
      params['venue_queries'] = []
      params['venue_queries'] << { 'name' => 'bistro central parc' }
      response = client.venues_search(params)

      expect(response['status']).to eq('success')
      expect(response['http_status']).to eq(200)
      expect(response['venues']).to be_an_instance_of(Array)
      response['venues'].each do |v|
        expect(v).to be_an_instance_of(Rlocu2::Venue)
      end

    end

    it 'Querying for venues in a circular area' do

      params = Hash.new
      params['fields'] = ['name','location','contact']
      params['venue_queries'] = []
      params['venue_queries'] << { 'location' => { 'geo' => {'$in_lat_lng_radius' => [37.7750, -122.4183, 5000] } } }
      response = client.venues_search(params)

      expect(response['status']).to eq('success')
      expect(response['http_status']).to eq(200)
      expect(response['venues']).to be_an_instance_of(Array)

      response['venues'].each do |v|
        expect(v).to be_an_instance_of(Rlocu2::Venue)
      end
    end

    it 'Querying for presence or absence of fields' do

      params = Hash.new
      params['fields'] = ['name','location','contact']
      params['venue_queries'] = []
      params['venue_queries'] << {'menus' => {'$present' => true}}
      response = client.venues_search(params)

      expect(response['status']).to eq('success')
      expect(response['http_status']).to eq(200)
      expect(response['venues']).to be_an_instance_of(Array)

      response['venues'].each do |v|
        expect(v).to be_an_instance_of(Rlocu2::Venue)
      end
    end

    it 'Querying for venues open during certain hours' do

      params = Hash.new
      params['fields'] = ['name','location','contact']
      params['venue_queries'] = []
      params['venue_queries'] << { 'open_hours' => { 'monday' => ['18:00', '20:00']} }
      response = client.venues_search(params)

      expect(response['status']).to eq('success')
      expect(response['http_status']).to eq(200)
      expect(response['venues']).to be_an_instance_of(Array)

      response['venues'].each do |v|
        expect(v).to be_an_instance_of(Rlocu2::Venue)
      end
    end
=begin
     # ?!? The "menu_items" key is not supported. (400)
     it 'Querying for all restaurants in Boston that serve pizza' do

      params = Hash.new
      params['fields'] = ['name']
      params['venue_queries'] = []
      params['venue_queries'] << { 'location' => { 'locality' => 'Boston'} }
      params['menu_item_queries'] = []
      params['menu_item_queries'] << { 'name' => 'pizza' }
      response = client.venues_search(params)

      expect(response['status']).to eq('success')
      expect(response['http_status']).to eq(200)
      expect(response['venues']).to be_an_instance_of(Array)

    end
=end
    it 'Querying for many attributes' do

      params = Hash.new
      params['fields'] = ['locu_id','name','description','website_url','location','categories','menus','open_hours','extended','description','short_name']
      params['venue_queries'] = []
      params['venue_queries'] << { 'name' => 'bistro central parc', 'menus' => {'$present' => true} }
      response = client.venues_search(params)

      expect(response['status']).to eq('success')
      expect(response['http_status']).to eq(200)
      expect(response['venues']).to be_an_instance_of(Array)

      response['venues'].each do |v|
        expect(v).to be_an_instance_of(Rlocu2::Venue)
      end
    end


  end

end