require 'oystercard'

describe Oystercard do
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
    subject.top_up(10)
    subject.touch_in
    expect(subject).to be_in_journey
  end
  
  it "ends journey when you touch out" do
    subject.top_up(10)
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it "Prevent you touching in below minimum value" do
    expect { subject.touch_in }.to raise_error("Error: Not enough money.")
  end

  it "charges min fare on touch_out" do
    subject.top_up 10
    subject.touch_in
    expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
  end
end
