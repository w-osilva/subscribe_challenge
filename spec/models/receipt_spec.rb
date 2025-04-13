# frozen_string_literal: true

RSpec.describe Receipt do
  let(:products) do
    [
      Product.new(price: 10.0, name: 'book', quantity: 1), # exempt
      Product.new(price: 20.0, name: 'music CD', quantity: 1), # not exempt
      Product.new(price: 15.0, name: 'imported chocolate', quantity: 1) # not exempt + imported
    ]
  end

  describe '#initialize' do
    it 'initializes with products' do
      receipt = described_class.new(products: products)
      expect(receipt.products).to eq(products)
    end
  end

  describe '#valid?' do
    context 'when products are present and valid' do
      it 'returns true' do
        receipt = described_class.new(products: products)
        expect(receipt).to be_valid
      end
    end

    context 'when products are empty' do
      it 'returns false' do
        receipt = described_class.new(products: [])
        expect(receipt).not_to be_valid
      end
    end
  end

  describe '#total_price' do
    it 'calculates the total price (with taxes) of the products' do
      receipt = described_class.new(products: products)
      expect(receipt.total_price).to eq(47.75)
    end
  end

  describe '#sales_tax_price' do
    it 'calculates the sales tax price of the products' do
      receipt = described_class.new(products: products)
      expect(receipt.sales_tax_price).to eq(2.75)
    end
  end
end
