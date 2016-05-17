require "pry"

class Rule

  attr_reader :bogof, :tid

  def initialize(args)
    @bogof  = args[:bogof]
    @tid    = args[:tid]
  end

  def discounts(items)
    b = buy_one_get_one_free(items) || 0
    t = three_item_discount(items) || 0
    b + t
  end


  private

  # def buy_one_get_one_free(items)
  #   discount_items = items.select { |i| (i[:c] == bogof) }
  #   puts "1 get 1 free"
  #   puts discount_items
  #     discount_items.size % 2 == 0 ? discount_items.map { |i| i[:v] / 2 }.reduce(:+) : discount_items.map { |i| i[:v] / 2 }.reduce(:+) #NOTE
  # end

  def buy_one_get_one_free(items)
    discount_items = items.select { |i| (i[:c] == bogof) }
    if discount_items.size >= 2
      items = discount_items.each_slice(2).to_a
      items.size > 2 ? items.delete_at(-1) : items.delete_at(1)
      # puts items
      # binding.pry
      items.flatten.map { |i| i[:v] / 2.0 }.reduce(:+)
    else
      0
    end
  end

  def three_item_discount(items)
    discount_items = items.select { |i| (i[:c] == tid) }
    discount_items.size >= 3 ? discount_items.length * 50 : 0
  end

end
