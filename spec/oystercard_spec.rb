require 'oystercard'

describe Oystercard do
  it "card has balance of 0 at start" do
    expect(subject.balance).to eq 0
  end
end