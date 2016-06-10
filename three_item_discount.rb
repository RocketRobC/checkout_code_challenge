require_relative 'rule'

class ThreeItemDiscount

  def discount(items, tid)
    discount_items = items.select { |i| (i[:c] == tid) }
    discount_items.size >= 3 ? discount_items.size * 50 : 0
  end

end
