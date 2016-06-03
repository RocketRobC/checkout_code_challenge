class Checkout

  attr_reader :items, :pricing_rules

  def initialize(args)
    @pricing_rules = args
  end

  def scan(item)
    (i = @items) || (i = [])
    @items = i << item
  end

  def items_before_discount
    items.map { |item| item[:v] }.reduce(:+)
  end

  def total
    (items_before_discount - pricing_rules.discounts(items)) / 100.00
  end

end
