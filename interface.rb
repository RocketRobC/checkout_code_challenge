require_relative "checkout"
require_relative "rule"


PRODUCTS = {
  "FR1" => { c: "FR1", v: 311 },
  "SR1" => { c: "SR1", v: 500 },
  "CF1" => { c: "CF1", v: 1123 },
}

pricing_rules = Rule.new(bogof: "FR1", tid: "SR1")
co = Checkout.new(pricing_rules)

co.scan(PRODUCTS["CF1"])
co.scan(PRODUCTS["CF1"])
co.scan(PRODUCTS["SR1"])
co.scan(PRODUCTS["SR1"])
co.scan(PRODUCTS["FR1"])
co.scan(PRODUCTS["FR1"])
co.scan(PRODUCTS["SR1"])
co.scan(PRODUCTS["FR1"])

price = co.total
puts price
