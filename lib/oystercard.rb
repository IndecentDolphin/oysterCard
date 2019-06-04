class OysterCard
    
    attr_reader :balance, :start_station

    # constants
    DEFAULT_BALANCE = 0
    MAX_LIMIT = 90
    MINIMUM_BALANCE = 1
    MINIMUM_FARE = 3
    

    def initialize
        @balance = DEFAULT_BALANCE
        @start_station
    end
    
    def top_up(amount)
        raise "Max balance reached, balance: #{balance}, balance limit: #{MAX_LIMIT}" if balance == MAX_LIMIT

        @balance += amount
    end

    def touch_in(station)
        raise "below minimum allowance" if balance < MINIMUM_BALANCE
        @start_station = station
    end

    def touch_out
        deduct(MINIMUM_FARE)
        @start_station = nil
    end

    def in_journey?
        @start_station != nil ? true : false
    end

    private 
    def deduct(fare)
        @balance -= fare
    end

end