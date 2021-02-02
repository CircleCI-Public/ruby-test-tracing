class OtherThingy
  attr_reader :orders

  def initialize
    @orders = []
  end

  def add_order(order)
    sleep 0.01
    @orders.append(order)
  end
end