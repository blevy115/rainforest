class Product < ApplicationRecord
  has_many :reviews

  validates :name, :description, :price_in_cents, presence: true
  validates :price_in_cents, numericality: {only_integer: true, greater_than_or_equal_to: 0}


  def a_method_for_validation_purposes
  end

  def price_in_dollars
    price_in_dollars = price_in_cents.to_f / 100
    sprintf("$%.2f", price_in_dollars)
  end
end
