require ('minitest/autorun')
require ('minitest/rg')
require_relative('../guest')
require_relative('../library')
require_relative('../bar')

class TestGuest < Minitest::Test
  def setup
    @library = Library.new
    @library.add_song("ABBA", "Waterloo", "pop", "abba_waterloo.mp3") 
    @library.add_song("Queen", "Bohemian Rhapsody", "rock", "queen_bohemian-rhapsody.mp3")

    @bar = Bar.new
    @bar.add_drink("vodka", "Grey Goose", 5.0)
    @bar.add_drink("vodka", "Smirnoff", 5.0)

    @guest = Guest.new("Reg Wailer", 5.0, {type: "vodka", brand: "Grey Goose"})
  end

  def test_choose_drink
    assert_equal(@bar.drinks_menu()[0], @guest.choose_drink(@bar))
  end

  def test_can_afford_drink
    assert_equal(true, @guest.can_afford_drink?(@bar.drinks_menu()[0]))
  end

  def test_buy_drink
    @guest.buy_drink(@bar.drinks_menu()[0])
    assert_equal(1, @guest.bar_tab.length)
    assert_equal(@bar.drinks_menu()[0], @guest.bar_tab[0])
  end

  def test_tab_total
    @guest.buy_drink(@bar.drinks_menu()[0])
    assert(5.0, @guest.tab_total)
  end

  def test_cannot_afford_drink
    @guest.buy_drink(@bar.drinks_menu()[0])
    assert_equal(false, @guest.can_afford_drink?(@bar.drinks_menu()[0]))
  end

  def test_library
    search_result = @library.song_search("genre", "pop")
    assert_equal(1, search_result.count)
    assert_equal("ABBA", search_result[0].artist)
    assert_equal("Waterloo", search_result[0].title)
  end

  def test_choose_song
    song = @guest.choose_song(@library)
    assert_equal("Waterloo", song.title)
    @guest.favourite_music[:genre] << "rock"
    @guest.favourite_music[:artist] << "Queen"
    @guest.favourite_music[:title] << "Bohemian Rhapsody"
    song = @guest.choose_song(@library)
    assert_equal("Bohemian Rhapsody", song.title)
  end
end