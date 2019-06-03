require "oystercard.rb"

describe OysterCard do

    it "Checks balance of oyster card" do
        expect(subject.balance).to eq(0.00)
        # subject.balance = 10
        subject.top_up(10)
        expect(subject.balance).to eq(10)
    end

    it "tops up card correctly to the input amount" do
        expect(subject.top_up(10.00)).to eq(10.00)
    end 

    it "should throw an error if balance > 90.00" do
        subject.top_up(90)
        expect {subject.top_up(1)}.to raise_exception "Max balance reached, balance: 90, balance limit: 90"
    end
    
    it "removes fare from card balance" do
        subject.top_up(10)
        expect(subject.deduct(3)).to eq(7)
    end

    it "starts and ends a user journey" do
        subject.touch_in 
        expect(subject).to be_in_journey
        subject.touch_out
        expect(subject).not_to be_in_journey
    end

end