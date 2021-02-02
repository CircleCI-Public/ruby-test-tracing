require "other_thingy"
require "db"

# A normal spec that knows nothing about Honeycomb
RSpec.describe OtherThingy do
  before :each do
    setup_db
  end

  it "should have no orders at startup" do
    thingy = OtherThingy.new
    expect(thingy.orders).to eq([])
  end

  it "should allow you to add an order" do
    thingy = OtherThingy.new
    thingy.add_order("order 1")
    expect(thingy.orders).to eq(["order 1"])
  end
end