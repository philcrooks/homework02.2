require ('minitest/autorun')
require ('minitest/rg')
require_relative('../bar')

class TestBar < Minitest::Test
  def setup
    @bar = Bar.new
    @bar.add_drink("vodka", "Grey Goose", 5.00)
    @bar.add_drink("vodka", "Smirnoff", 4.50)
    @bar.add_drink("whisky", "Glenmorangie", 5.00)
    @bar.add_drink("whisky", "Glen Turret", 5.00)
  end

  def test_full_drinks_menu
    menu = @bar.drinks_menu()
    assert_equal(4, menu.length)
    assert_equal("Smirnoff", menu[1].brand)
  end

  def test_drinks_menu_category
    menu = @bar.drinks_menu("whisky")
    assert_equal(2, menu.length)
    assert_equal("Glen Turret", menu[1].brand)
  end

  def test_to_s
    for drink in @bar.drinks
      puts drink.to_s
    end
  end

end