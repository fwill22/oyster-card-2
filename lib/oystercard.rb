class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey_list
  DEFAULT_VALUE = 0
  MAX_VALUE = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_VALUE)
    @balance = balance
    @journey_list = []
  end

  def top_up(money)
    raise "Error: New balance over £#{MAX_VALUE}." if (@balance + money) > MAX_VALUE
    @balance += money
  end

  def touch_in(entry_station)
    raise "Error: Insufficient funds." if @balance < MINIMUM_FARE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @exit_station = exit_station
    record_journey
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  def record_journey
    @journey_list << { @entry_station => @exit_station }
  end
  
  private
  def deduct(fare)
    @balance -= fare
  end
end
