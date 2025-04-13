# frozen_string_literal: true

RSpec.describe Product do
  describe '#initialize' do
    it 'initializes with a name, price, and quantity' do
      product = described_class.new(name: 'book', price: 10.00, quantity: 1)
      expect(product.name).to eq('book')
      expect(product.price).to eq(10.00)
      expect(product.quantity).to eq(1)
    end
  end

  describe '#valid?' do
    context 'when quantity and price are positive' do
      it 'returns true' do
        product = described_class.new(name: 'book', price: 10.00, quantity: 1)
        expect(product).to be_valid
      end
    end

    context 'when quantity is zero or negative' do
      it 'returns false with zero quantity' do
        product = described_class.new(name: 'book', price: 10.00, quantity: 0)
        expect(product).not_to be_valid
      end

      it 'returns false with negative quantity' do
        product = described_class.new(name: 'book', price: 10.00, quantity: -1)
        expect(product).not_to be_valid
      end
    end

    context 'when price is zero or negative' do
      it 'returns false with zero price' do
        product = described_class.new(name: 'book', price: 0.0, quantity: 1)
        expect(product).not_to be_valid
      end

      it 'returns false with negative price' do
        product = described_class.new(name: 'book', price: -1.0, quantity: 1)
        expect(product).not_to be_valid
      end
    end
  end

  describe '#sales_tax_price' do
    context 'when the product is exempt from sales tax' do
      it 'returns 0' do
        product = described_class.new(name: 'book', price: 10.00, quantity: 1)
        expect(product.sales_tax_price).to eq(0)
      end
    end

    context 'when the product is not exempt from sales tax' do
      it 'calculates the sales tax price' do
        product = described_class.new(name: 'music CD', price: 10.00, quantity: 1)
        expect(product.sales_tax_price).to eq(1.00)
      end
    end
  end

  describe '#import_tax_price' do
    context 'when the product is imported' do
      it 'calculates the import tax price' do
        product = described_class.new(name: 'imported chocolate', price: 10.00, quantity: 1)
        expect(product.import_tax_price).to eq(0.50)
      end
    end

    context 'when the product is not imported' do
      it 'returns 0' do
        product = described_class.new(name: 'book', price: 10.00, quantity: 1)
        expect(product.import_tax_price).to eq(0)
      end
    end
  end

  describe '#total_tax_price' do
    context 'when the product has both sales and import tax' do
      it 'calculates the total tax price' do
        product = described_class.new(name: 'imported music CD', price: 10.00, quantity: 1)
        expect(product.total_tax_price).to eq(1.50)
      end
    end

    context 'when the product has only sales tax' do
      it 'calculates the total tax price' do
        product = described_class.new(name: 'music CD', price: 10.00, quantity: 1)
        expect(product.total_tax_price).to eq(1.00)
      end
    end

    context 'when the product has only import tax' do
      it 'calculates the total tax price' do
        product = described_class.new(name: 'imported chocolate', price: 10.00, quantity: 1)
        expect(product.total_tax_price).to eq(0.50)
      end
    end

    context 'when the product is exempt from sales and import tax' do
      it 'returns 0' do
        product = described_class.new(name: 'book', price: 10.00, quantity: 1)
        expect(product.total_tax_price).to eq(0)
      end
    end
  end

  describe '#total_price' do
    context 'when the product has no taxes' do
      it 'calculates the total price' do
        product = described_class.new(name: 'book', price: 10.00, quantity: 1)
        expect(product.total_price).to eq(10.00)
      end
    end

    context 'when the product has sales tax' do
      it 'calculates the total price' do
        product = described_class.new(name: 'music CD', price: 10.00, quantity: 1)
        expect(product.total_price).to eq(11.00)
      end
    end

    context 'when the product has import tax' do
      it 'calculates the total price' do
        product = described_class.new(name: 'imported chocolate', price: 10.00, quantity: 1)
        expect(product.total_price).to eq(10.50)
      end
    end

    context 'when the product has both sales and import tax' do
      it 'calculates the total price' do
        product = described_class.new(name: 'imported music CD', price: 10.00, quantity: 1)
        expect(product.total_price).to eq(11.50)
      end
    end
  end

  describe '#imported?' do
    context 'when the product is imported' do
      it 'returns true' do
        product = described_class.new(name: 'imported chocolate', price: 10.00, quantity: 1)
        expect(product).to be_imported
      end
    end

    context 'when the product is not imported' do
      it 'returns false' do
        product = described_class.new(name: 'book', price: 10.00, quantity: 1)
        expect(product).not_to be_imported
      end
    end
  end
end
