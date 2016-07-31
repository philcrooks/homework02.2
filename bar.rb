require_relative ('./drink')

class Bar
  attr_reader :drinks
  def initialize
    @drinks = []
  end

  def add_drink (type, brand, price)
    @drinks << Drink.new(type, brand, price)
  end

  def drinks_menu(category = nil)
    return category ? @drinks.select{ |drink| drink.type.downcase == category.downcase } : @drinks
  end
end