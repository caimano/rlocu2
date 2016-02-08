require 'spec_helper'

describe Rlocu2 do
  after do
    Rlocu2.reset
  end

  describe ".client" do
    it "should be a Rlocu2::Client" do
      expect(Rlocu2.client).to be_an_instance_of(Rlocu2::Client)
    end
  end

end