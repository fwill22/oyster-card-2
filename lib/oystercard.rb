class Oystercard
  attr_reader :balance
  DEFAULT_VALUE = 0
  MAX_VALUE = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_VALUE)
    @balance = balance
    @in_use = false
  end

  def top_up(money)
    raise "Error: New balance over £#{MAX_VALUE}." if (@balance + money) > MAX_VALUE
    @balance += money
  end

  def touch_in
    raise "Error: Not enough money." if @balance < MINIMUM_FARE
    @in_use = true
  end

  def touch_out
    @in_use = false
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    @in_use
  end
  
  private
  def deduct(fare)
    @balance -= fare
  end
end