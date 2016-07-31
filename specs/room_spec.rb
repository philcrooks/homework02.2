require ('minitest/autorun')
require ('minitest/rg')
require_relative('../library')
require_relative('../bar')
require_relative('../room')
require_relative('../guest')

class TestRoom < Minitest::Test
  def setup
    @library = Library.new()
    @library.add_song("ABBA", "Waterloo", "pop", "abba_waterloo.mp3") 
    @library.add_song("Queen", "Bohemian Rhapsody", "rock", "queen_bohemian-rhapsody.mp3")

    @bar = Bar.new
    @bar.add_drink("vodka", "Grey Goose", 5.0)
    @bar.add_drink("vodka", "Smirnoff", 5.0)
    @bar.add_drink("whisky", "Glenmorangie", 5.0)
    @bar.add_drink("whisky", "Glen Turret", 5.0)

    @guest1 = Guest.new("Reg Wailer", 5.0, { type: "vodka", brand: "Grey Goose" })
    @guest2 = Guest.new("Craig Crooner", 5.0, { type: "whisky", brand: "Glen Turret" })

    @room = Room.new("Test Room", 2, @library, @bar)
  end

  def test_initialize
    assert_equal("Test Room", @room.name)
  end

  def test_add_occupant
    @room.add_occupant(@guest1)
    assert_equal(@guest1, @room.occupants[0])
    assert_equal(@guest1, @room.new_arrivals[0])
  end

  def test_capacity
    @room.add_occupant(@guest1)
    @room.add_occupant(@guest2)
    assert_equal(true, @room.at_capacity?)
  end

  def test_singer
    @room.add_occupant(@guest1)
    assert_equal(@room.occupants[0], @room.singer)
    @room.add_occupant(@guest2)
    assert_equal(@room.occupants[0], @room.singer)
  end

  def test_change_singer
    @room.add_occupant(@guest1)
    @room.add_occupant(@guest2)
    singer1 = @room.singer
    @room.change_singer
    singer2 = @room.singer
    assert_equal(false, singer1 == singer2)
    @room.change_singer
    singer2 = @room.singer
    assert_equal(true, singer1 == singer2)
  end
end