require 'station'

describe Station do
  context "#initialize" do
    it "should have a name do" do
      expect(subject.name).to eq(subject.name)
    end

    it "should have a zone do" do
      expect(subject.zone).to eq(subject.zone)
    end
  end
end