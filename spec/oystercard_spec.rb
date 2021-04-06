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

  it "deducts money from balance" do
    subject.top_up(10)
    subject.deduct(5)
    expect(subject.balance).to eq(5)
  end

  it "responds to touch in" do
    expect(subject).to respond_to(:touch_in)
  end

  it "starts journey when you touch in" do
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it "responds to touch out" do
    expect(subject).to respond_to(:touch_out)
  end
  
  it "ends journey when you touch out" do
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

end