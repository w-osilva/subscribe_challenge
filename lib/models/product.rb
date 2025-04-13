# frozen_string_literal: true

class Product
  attr_reader :name, :quantity, :price

  SALES_TAX_RATE = 0.10 # 10%
  IMPORT_TAX_RATE = 0.05 # 5%
  TAX_EXEMPT_CATEGORIES = %w[book food chocolate pill medicine].freeze

  def initialize(name:, quantity:, price:)
    @name = name
    @quantity = quantity
    @price = price
  end

  def valid?
    quantity.positive? && price.positive?
  end

  def sales_tax_price
    return 0 if exempt_from_sales_tax?

    raw_tax = price * SALES_TAX_RATE
    round_up_to_nearest_0_05(raw_tax) * quantity
  end

  def import_tax_price
    return 0 unless imported?

    raw_tax = price * IMPORT_TAX_RATE
    round_up_to_nearest_0_05(raw_tax) * quantity
  end

  def total_tax_price
    sales_tax_price + import_tax_price
  end

  def total_price
    (price * quantity) + total_tax_price
  end

  def imported?
    name.downcase.include?('imported')
  end

  private

  def exempt_from_sales_tax?
    TAX_EXEMPT_CATEGORIES.any? { |category| name.downcase.include?(category) }
  end

  def round_up_to_nearest_0_05(value)
    (value * 20).ceil / 20.0
  end
end
