require 'oystercard'

describe Oystercard do
  it "card has balance of 0 at start" do
    expect(subject.balance).to eq 0
  end

  it "responds to the top up method" do
    expect(subject).to respond_to(:top_up)
  end

  it "adds money to balance" do
    subject.top_up(10)
    expect(subject.balance).to eq(10)
  end
  
  it "error is new balance exceeds limit" do
    max = Oystercard::MAX_VALUE
    expect { subject.top_up(max + 1) }.to raise_error("Error: New balance over £#{max}.")
  end
end