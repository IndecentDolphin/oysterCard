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

    it "starts and ends a user journey" do
        subject.top_up(10)
        subject.touch_in 
        expect(subject).to be_in_journey
        subject.touch_out
        expect(subject).not_to be_in_journey
    end

    it "validates a minimum amount for a journey" do
        expect{subject.touch_in}.to raise_exception "below minimum allowance"
    end

    it "deducts the correct fare from balance" do
        subject.top_up(10)
        subject.touch_out
        expect(subject.balance).to eq(7)
    end

    it "deducts the correct fare from balance" do
        expect {subject.touch_out }.to change{subject.balance}.by -3
    end
end