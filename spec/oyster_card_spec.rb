require "oystercard.rb"

describe OysterCard do

    it "Checks balance of oyster card" do
        expect(subject.balance).to eq(0.00)
    end

end