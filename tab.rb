require_relative('./drink.rb')

class Tab
  attr_accessor :tab

  def initialize(name, credit)
    @name = name
    @credit = credit
    @tab = []
  end

  def add (drink)
    @tab << drink
  end

  def total
    sum = 0.0
    for drink in @tab
      sum += drink.price
    end
    return sum
  end

  def to_s
    # This should be in the venue - guest is not the right place for the method.
    s = "%s (credit: %0.2f)\n" % [@name, @credit]
    for drink in @tab
      s += "   #{drink}\n"
    end
    s += "   %-20s %6.2f\n" % ["TOTAL", total()]
    return s
  end
end