class OysterCard
    
    attr_reader :balance
    DEFAULT_BALANCE = 0.00
    MAX_LIMIT = 90.00

    def initialize
        @balance = DEFAULT_BALANCE
    end
    
    def top_up(amount)
        raise "Max balance reached" if balance == MAX_LIMIT
        
        @balance += amount
    end
end