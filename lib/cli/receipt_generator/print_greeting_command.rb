# frozen_string_literal: true

module ReceiptGenerator
  class PrintGreetingCommand < BaseCommand
    GREETING = <<~TEXT.freeze
      Please enter the items you want to add to your receipt. Press 'Enter' when you are finished.

      The input must follow the format: '{quantity} {item} at {price}'.#{' '}
      e.g: 1 book at 12.49

    TEXT

    def execute
      execution do
        puts GREETING
      end
    end
  end
end
