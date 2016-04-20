class Rule

  attr_reader :bogof, :tid

  def initialize(args)
    @bogof  = args[:bogof]
    @tid    = args[:tid]
  end

  def discounts(items)
    b = buy_one_get_one_free(items)
    t = three_item_discount(items)
    b + t
  end


  private

  #NOTE need to work on these methods, they're not grouping values into groups of 2 or 3

  def buy_one_get_one_free(items)
      discount_items = items.select { |i| (i[:c] == bogof) }
        discount_items.map { |i| i[:v] / 2 }.reduce(:+) if discount_items.size % 2 == 0
  end

  def three_item_discount(items)
      discount_items = items.select { |i| (i[:c] == tid) }
        discount_items.map { |i| i[:v] - 450 }.reduce(:+) if discount_items.size % 3 == 0
  end

end
