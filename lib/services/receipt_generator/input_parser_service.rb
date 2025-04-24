# frozen_string_literal: true

module ReceiptGenerator
  class InputParserService < Service
    INPUT_REGEX = /\A(\d+)\s+(.+?)\s+at\s+(\d+(\.\d{1,2})?)\z/

    attr_reader :input

    def initialize(input)
      @input = input
    end

    def call
      parse_input
    end

    private

    def parse_input
      if input.match?(INPUT_REGEX)
        quantity, item, price = input.match(INPUT_REGEX).captures
        Product.new(name: item, quantity: quantity.to_i, price: price.to_f)
      else
        false
      end
    end
  end
end
