class Oystercard
  attr_reader :balance
  DEFAULT_VALUE = 0
  MAX_VALUE = 90

  def initialize(balance = DEFAULT_VALUE)
    @balance = balance
    @in_use = false
  end

  def top_up(money)
    raise "Error: New balance over £#{MAX_VALUE}." if (@balance + money) > MAX_VALUE
    @balance += money
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  def in_journey?
    @in_use
  end

end