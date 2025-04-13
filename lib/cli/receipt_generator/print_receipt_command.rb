# frozen_string_literal: true

module ReceiptGenerator
  class PrintReceiptCommand < BaseCommand
    attr_reader :receipt, :products

    def initialize(products)
      @products = products
      @receipt = nil
    end

    def execute
      @receipt = Receipt.new(products: products)

      execution do
        print_receipt
      end
    end

    private

    # rubocop:disable Metrics/AbcSize
    def print_receipt
      output = receipt.products.map do |item|
        "#{item.quantity} #{item.name}: #{format('%.2f', item.total_price)}"
      end
      output << "Sales Taxes: #{format('%.2f', receipt.sales_tax_price)}"
      output << "Total: #{format('%.2f', receipt.total_price)}"

      puts output.join("\n")
    end
    # rubocop:enable Metrics/AbcSize
  end
end
