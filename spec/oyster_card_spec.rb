require "oystercard.rb"

describe OysterCard do

    it "Checks balance of oyster card" do
        expect(subject.balance).to eq(0.00)
    end

    it "tops up card correctly to the input amount" do
        expect(subject.top_up(10.00)).to eq(10.00)
    end 
   
    # In order to protect my money from theft or loss
    # As a customer
    # I want a maximum limit (of £90) on my card

    it "should throw an error if balance > 90.00" do
        subject.top_up(90.00)
        expect {subject.top_up(1.00)}.to raise_exception "Max balance reached"
    end

end