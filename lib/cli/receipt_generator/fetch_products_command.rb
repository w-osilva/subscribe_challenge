# frozen_string_literal: true

module ReceiptGenerator
  class FetchProductsCommand < Command
    INVALID_INPUT_MESSAGE = <<~TEXT
      Please enter a valid item description following the format: '{quantity} {item} at {price}'
    TEXT

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

        parsed_input = InputParserService.call(input)

        if parsed_input.is_a?(Product) && parsed_input.valid?
          @products << parsed_input
        else
          puts INVALID_INPUT_MESSAGE
        end
      end
    end
  end
end
