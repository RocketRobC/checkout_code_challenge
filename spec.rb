require 'rspec'
require_relative 'checkout'
require_relative 'rule'

PRODUCTS = {
  "FR1" => { c: "FR1", v: 311 },
  "SR1" => { c: "SR1", v: 500 },
  "CF1" => { c: "CF1", v: 1123 },
}

describe 'checkout' do
  before(:each) do
    pricing_rules = Rule.new(bogof: "FR1", tid: "SR1")
    @co = Checkout.new(pricing_rules)
  end

  context '2 for 1' do
    it 'applies a 2 for 1 discount to 4 items' do
      4.times { @co.scan(PRODUCTS["FR1"]) }
      price = @co.total
      expect(price).to eq(6.22)
    end

    it 'applies a 2 for 1 discount to 2 items' do
      2.times { @co.scan(PRODUCTS["FR1"]) }
      price = @co.total
      expect(price).to eq(3.11)
    end

    it 'applies a 2 for 1 discount to 3 items' do
      3.times { @co.scan(PRODUCTS["FR1"]) }
      price = @co.total
      expect(price).to eq(6.22)
    end

    it 'applies a 2 for 1 discount to 5 items' do
      5.times { @co.scan(PRODUCTS["FR1"]) }
      price = @co.total
      expect(price).to eq(9.33)
    end
    it 'applies a 2 for 1 discount to 6 items' do
      6.times { @co.scan(PRODUCTS["FR1"]) }
      price = @co.total
      expect(price).to eq(9.33)
    end

    it "doesn't apply a 2 for 1 discount to 1 items" do
      @co.scan(PRODUCTS["FR1"])
      price = @co.total
      expect(price).to eq(3.11)
    end
  end

  context '3 item or more discount' do
    it 'reduced the cost of 3 items to 4.50 each' do
      3.times { @co.scan(PRODUCTS['SR1']) }
      price = @co.total
      expect(price).to eq(13.50)
    end

    it 'reduced the cost of 4 items to 4.50 each' do
      4.times { @co.scan(PRODUCTS['SR1']) }
      price = @co.total
      expect(price).to eq(18.00)
    end

    it "doesn't reduce the cost of less than 2 items" do
      2.times { @co.scan(PRODUCTS['SR1']) }
      price = @co.total
      expect(price).to eq(10.00)
    end
  end

  context 'mixed purchases' do
    it 'calculates a basket containing FR1,SR1,FR1,FR1,CF1 correctly' do
      @co.scan(PRODUCTS['FR1'])
      @co.scan(PRODUCTS['SR1'])
      @co.scan(PRODUCTS['FR1'])
      @co.scan(PRODUCTS['FR1'])
      @co.scan(PRODUCTS['CF1'])
      price = @co.total
      expect(price).to eq(22.45)
    end

    it 'calculates a basket containing SR1,SR1,FR1,SR1 correctly' do
      @co.scan(PRODUCTS['SR1'])
      @co.scan(PRODUCTS['SR1'])
      @co.scan(PRODUCTS['FR1'])
      @co.scan(PRODUCTS['SR1'])
      price = @co.total
      expect(price).to eq(16.61)
    end
  end
end
