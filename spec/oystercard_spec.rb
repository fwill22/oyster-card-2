require 'oystercard'

describe Oystercard do
  let (:entry_station) { double :station }
  let (:exit_station) { double :station }

  let(:top_up_and_touch_in) do 
    subject.top_up(10)
    subject.touch_in(entry_station)
  end

  it "card has balance of 0 at start" do
    expect(subject.balance).to eq 0
  end

  it "adds money to balance" do
    subject.top_up(10)
    expect(subject.balance).to eq(10)
  end
  
  it "error is new balance exceeds limit" do
    max = Oystercard::MAX_VALUE
    expect { subject.top_up(max + 1) }.to raise_error("Error: New balance over £#{max}.")
  end

  it "starts journey when you touch in" do
    top_up_and_touch_in
    expect(subject).to be_in_journey
  end
  
  context "#touch_out" do
    it { is_expected.to respond_to(:touch_out).with(1).argument }
  end

  it "ends journey when you touch out" do
    top_up_and_touch_in
    subject.touch_out(exit_station)
    expect(subject).not_to be_in_journey
  end

  it "Prevents you touching in below minimum value" do
    expect { subject.touch_in(entry_station) }.to raise_error("Error: Insufficient funds.")
  end

  it "charges min fare on touch_out" do
    top_up_and_touch_in
    expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
  end

  it "remembers the entry station after the touch in" do
    top_up_and_touch_in
    expect(subject.entry_station).to eq entry_station
  end

  it "forgets the entry station after touch out" do
    top_up_and_touch_in
    subject.touch_out(exit_station)
    expect(subject.entry_station).to eq nil
  end

  context "#journey_list" do
    it "should have a list of journeys" do
      expect(subject.journey_list).to eq(subject.journey_list)
    end
  end

  it "should have an empty list of journeys" do
    expect(subject.journey_list).to be_empty
  end

  context "#record_jouney" do
    it "should create a journey hash" do
      top_up_and_touch_in
      subject.touch_out(exit_station)
      expect(subject.journey_list).to include({ entry_station => exit_station })
    end
  end

end

