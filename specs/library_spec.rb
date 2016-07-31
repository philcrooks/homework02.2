require ('minitest/autorun')
require ('minitest/rg')
require_relative('../library')

class TestLibrary < Minitest::Test
  def setup
    @library = Library.new
    @library.add_song("ABBA", "Waterloo", "pop", "abba_waterloo.mp3") 
    @library.add_song("ABBA", "Dancing Queen", "pop", "abba_dancing-queen.mp3")
    @library.add_song("Queen", "Bohemian Rhapsody", "rock", "queen_bohemian-rhapsody.mp3")
    @library.add_song("Ed Sheeran", "Talking Out Loud", "pop,rock", "ed-sheeran_talking-out-loud.mp3")
  end

  def test_library_has_song
    assert_equal("ABBA", @library.songs[0].artist)
    assert_equal("Waterloo", @library.songs[0].title)
  end

  def test_song_search_by_title
    search_result = @library.song_search("title", "waterloo")
    assert_equal(1, search_result.count)
    assert_equal("ABBA", search_result[0].artist)
    assert_equal("Waterloo", search_result[0].title)
  end

  def test_song_search_by_artist
    search_result = @library.song_search("artist", "abba")
    assert_equal(2, search_result.count)
    assert_equal("ABBA", search_result[1].artist)
    assert_equal("Dancing Queen", search_result[1].title)
  end

  def test_song_search_by_genre
    search_result = @library.song_search("genre", "pop")
    assert_equal(3, search_result.count)
    assert_equal("ABBA", search_result[1].artist)
    assert_equal("Dancing Queen", search_result[1].title)
  end

  def test_song_search_using_symbol
    search_result = @library.song_search(:genre, "rock")
    assert_equal(2, search_result.count)
    assert_equal("Queen", search_result[0].artist)
    assert_equal("Bohemian Rhapsody", search_result[0].title)
  end
end