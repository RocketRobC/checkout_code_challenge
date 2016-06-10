require_relative 'rule'

class BuyOneGetOneFree

  def discount(items, bogof)
    discount_items = items.select { |i| (i[:c] == bogof) }
    if discount_items.size >= 2
      paired_items = discount_items.each_slice(2).to_a
      paired_items.delete_at(-1) if paired_items.flatten.size % 2 == 1
      paired_items.flatten.map { |i| i[:v] / 2.0 }.reduce(:+)
    else
      0
    end
  end

end
