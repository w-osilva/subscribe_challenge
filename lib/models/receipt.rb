# frozen_string_literal: true

class Receipt
  attr_accessor :products

  def initialize(products: [])
    @products = products
  end

  def valid?
    products.any? && products.all?(&:valid?)
  end

  def total_price
    products.sum(&:total_price)
  end

  def sales_tax_price
    products.sum(&:total_tax_price)
  end
end
