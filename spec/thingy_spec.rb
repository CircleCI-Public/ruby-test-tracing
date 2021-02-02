require "thingy"
require "db"

# A normal spec that knows nothing about Honeycomb
RSpec.describe Thingy do
  before :each do
    setup_db
  end

  it "should have no orders at startup" do
    thingy = Thingy.new
    expect(thingy.orders).to eq([])
  end

  it "should allow you to add an order" do
    thingy = Thingy.new
    thingy.add_order("order 1")
    expect(thingy.orders).to eq(["order 1"])
  end
end