require 'spec_helper'

describe Rlocu2 do
  let(:client) do
    client = Rlocu2::Client.new(:api_key => API_KEY)
  end

  context 'Rlocu2' do
    it 'client should be a Rlocu2::Client' do
      expect(client).to be_an_instance_of(Rlocu2::Client)
    end
  end

end