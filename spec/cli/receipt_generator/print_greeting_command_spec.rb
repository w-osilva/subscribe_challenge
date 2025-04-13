# frozen_string_literal: true

RSpec.describe ReceiptGenerator::PrintGreetingCommand do
  describe '#execute' do
    it 'prints a greeting message' do
      expected_output = <<~TEXT
        Please enter the items you want to add to your receipt. Press 'Enter' when you are finished.

        The input must follow the format: '{quantity} {item} at {price}'.#{' '}
        e.g: 1 book at 12.49

      TEXT

      expect { described_class.execute }.to output(expected_output).to_stdout
    end
  end
end
