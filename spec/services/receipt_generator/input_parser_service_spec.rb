# frozen_string_literal: true

RSpec.describe ReceiptGenerator::InputParserService do
  subject(:service) { described_class.new(input) }

  describe '#call' do
    context 'with valid input' do
      let(:input) { '2 apples at 1.50' }
      let(:expected_product) { Product.new(name: 'apples', quantity: 2, price: 1.50) }

      it 'returns a Product object with correct attributes' do
        result = service.call
        expect(result).to be_a(Product)
        expect(result).to be_valid
        expect(result.name).to eq(expected_product.name)
        expect(result.quantity).to eq(expected_product.quantity)
        expect(result.price).to eq(expected_product.price)
      end
    end
  end

  context 'with invalid input' do
    let(:input) { 'invalid input' }

    it 'returns false' do
      result = service.call
      expect(result).to be_falsey
    end
  end
end
