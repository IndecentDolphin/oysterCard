class OysterCard
    
    attr_reader :balance, :journey_list, :current_journey

    # constants
    DEFAULT_BALANCE = 0
    MAX_LIMIT = 90
    MINIMUM_BALANCE = 1
    MINIMUM_FARE = 3
    PENALTY_CHARGE = 5
    

    def initialize
        @balance = DEFAULT_BALANCE
        @journey_list = {}
        @current_journey = []
        @journey_number = 0
    end
    
    def top_up(amount)
        raise "Max balance reached, balance: #{balance}, balance limit: #{MAX_LIMIT}" if balance == MAX_LIMIT

        @balance += amount
    end

    def touch_in(station)
        raise "below minimum allowance" if balance < MINIMUM_BALANCE
        # deduct(PENALTY_CHARGE) if @current_journey.length == 1

        if @current_journey.length == 1
            deduct(PENALTY_CHARGE)
            store("INCOMPLETE_JOURNEY")
        end

        store(station)
    end

    def touch_out(station)
        deduct(MINIMUM_FARE)
        store(station)
    end

    def in_journey?
        !@current_journey.empty?
    end

    def store(input)
        
        current_journey << input
        if current_journey.length == 2
            key = "journey_#{@journey_number + 1}".to_sym
            journey_list[key] = current_journey
            #generate hash

            @journey_number += 1
            @current_journey = []
        end
        journey_list
    end

    private 
    def deduct(fare)
        @balance -= fare
    end
end