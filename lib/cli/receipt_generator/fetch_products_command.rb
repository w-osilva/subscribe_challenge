# frozen_string_literal: true

module ReceiptGenerator
  class FetchProductsCommand < Command
    INVALID_INPUT_MESSAGE = <<~TEXT
      Please enter a valid item description following the format: '{quantity} {item} at {price}'
    TEXT

    INPUT_REGEX = /\A(\d+)\s+(.+?)\s+at\s+(\d+(\.\d{1,2})?)\z/

    attr_reader :products

    def initialize
      @products = []
    end

    def execute
      fetch_user_inputs
      self
    end

    private

    def fetch_user_inputs
      loop do
        print '> '
        input = gets.strip
        if input.downcase == ''
          puts ''
          break
        end

        parsed = parse_input(input)

        if parsed.is_a?(Product) && parsed.valid?
          @products << parsed
        else
          puts INVALID_INPUT_MESSAGE
        end
      end
    end

    def parse_input(input)
      if input.match?(INPUT_REGEX)
        quantity, item, price = input.match(INPUT_REGEX).captures
        Product.new(name: item, quantity: quantity.to_i, price: price.to_f)
      else
        false
      end
    end
  end
end
