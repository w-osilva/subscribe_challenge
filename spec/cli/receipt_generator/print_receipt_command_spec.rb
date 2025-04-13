# frozen_string_literal: true

RSpec.describe ReceiptGenerator::PrintReceiptCommand do
  describe '#execute' do
    it 'prints the receipt from scenario 1' do
      products = [
        Product.new(quantity: 2, name: 'book', price: 12.49),
        Product.new(quantity: 1, name: 'music CD', price: 14.99),
        Product.new(quantity: 1, name: 'chocolate bar', price: 0.85)
      ]

      expected_output = <<~OUTPUT
        2 book: 24.98
        1 music CD: 16.49
        1 chocolate bar: 0.85
        Sales Taxes: 1.50
        Total: 42.32
      OUTPUT

      expect { described_class.execute(products) }.to output(expected_output).to_stdout
    end

    it 'prints the receipt from scenario 2' do
      products = [
        Product.new(quantity: 1, name: 'imported box of chocolates', price: 10.00),
        Product.new(quantity: 1, name: 'imported bottle of perfume', price: 47.50)
      ]

      expected_output = <<~OUTPUT
        1 imported box of chocolates: 10.50
        1 imported bottle of perfume: 54.65
        Sales Taxes: 7.65
        Total: 65.15
      OUTPUT

      expect { described_class.execute(products) }.to output(expected_output).to_stdout
    end

    it 'prints the receipt from scenario 3' do
      products = [
        Product.new(quantity: 1, name: 'imported bottle of perfume', price: 27.99),
        Product.new(quantity: 1, name: 'bottle of perfume', price: 18.99),
        Product.new(quantity: 1, name: 'packet of headache pills', price: 9.75),
        Product.new(quantity: 3, name: 'imported boxes of chocolates', price: 11.25)
      ]

      expected_output = <<~OUTPUT
        1 imported bottle of perfume: 32.19
        1 bottle of perfume: 20.89
        1 packet of headache pills: 9.75
        3 imported boxes of chocolates: 35.55
        Sales Taxes: 7.90
        Total: 98.38
      OUTPUT

      expect { described_class.execute(products) }.to output(expected_output).to_stdout
    end
  end
end
