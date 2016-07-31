class Song
  # A song knows nothing other than what it is and where it is.
  # The only thing it can do is to play itself

  SONG_TITLE = :title
  ARTIST = :artist
  GENRE = :genre
  CATEGORIES = [SONG_TITLE, ARTIST, GENRE]

  attr_reader :artist,:title,:genre,:location
  def initialize(artist, title, genre, location)
    @artist = artist
    @title = title
    @genre = genre
    @location = location
  end

end