class Oystercard
  attr_reader :balance
  DEFAULT_VALUE = 0
  MAX_VALUE = 90

  def initialize(balance = DEFAULT_VALUE)
    @balance = balance
  end

  def top_up(money)
    raise "Error: New balance over £#{MAX_VALUE}." if (@balance + money) > MAX_VALUE
    @balance += money
  end
end