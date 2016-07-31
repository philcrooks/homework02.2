class Drink
  attr_reader :type, :brand, :price
  def initialize (type, brand, price)
    @type = type
    @brand = brand
    @price = price
  end

  def to_s
    return "%-20s %6.2f" % [@brand, @price]
  end
end
