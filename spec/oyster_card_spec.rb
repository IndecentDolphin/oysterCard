require "oystercard.rb"

describe OysterCard do
    # In order to use public transport
    # As a customer
    # I want money on my card
    it "Checks balance of oyster card" do
        expect(subject.balance).to eq(10.00)
    end

end