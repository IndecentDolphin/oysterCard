require 'station.rb'

describe Station do

    let(:name){ double :name }
    let(:zone){ double :zone }


    it "instantiates with a name " do
        station = Station.new(name, zone)
        expect(station.name).to eq(name)
    end

    it "instantiates with a zone " do
        station = Station.new(name, zone)
        expect(station.zone).to eq(zone)
    end
end