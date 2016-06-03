require "pry"
require_relative 'buy_one_get_one_free'
require_relative 'three_item_discount'

class Rule

  attr_reader :bogof, :tid

  def initialize(args)
    @bogof  = args[:bogof]
    @tid    = args[:tid]
  end

  def discounts(items)
    b = BuyOneGetOneFree.discount(items, bogof) || 0
    t = ThreeItemDiscount.discount(items, tid) || 0
    b + t
  end

end
