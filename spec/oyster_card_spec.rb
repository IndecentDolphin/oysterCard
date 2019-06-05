require "oystercard.rb"

describe OysterCard do
    #variables
    let(:station){ double :station }
    let(:setup_journey) {subject.top_up(10); subject.touch_in(station); subject.touch_out(station)}

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
        subject.touch_in(station)
        expect(subject).to be_in_journey
        subject.touch_out(station)
        expect(subject).not_to be_in_journey
    end

    it "validates a minimum amount for a journey" do
        expect{subject.touch_in(station)}.to raise_exception "below minimum allowance"
    end

    it "deducts the correct fare from balance" do
        setup_journey
        expect(subject.balance).to eq(7)
    end

    it "deducts the correct fare from balance" do
        expect {subject.touch_out(station) }.to change{subject.balance}.by -3
    end

  
    it "stores the station the card was topped up in" do
        subject.top_up(10)
        subject.touch_in(station)
        expect(subject.current_journey).to eq([station])
    end
    
    it "checks that a new card has no journeys listed" do
        expect(subject.journey_list).to be_empty
    end

    it "creates a history hash which contains 1 journey" do
        setup_journey
        expect(subject.journey_list).to eq({:journey_1 => [station, station]})
    end

    # In order to be charged correctly
    # As a customer
    # I need a penalty charge deducted if I fail to touch in or out

    # User tops up card
    # User touches in at start station
    # User misses touching out at exit station
    # User touches in at start station_2
    # User receives penalty charge\

    it "deducts a penalty charge if a journey is left incomplete and a new journey is started" do
        subject.top_up(10)
        subject.touch_in(station)
        subject.touch_in("New Cross")
        expect(subject.balance).to eq(5)
    end
end