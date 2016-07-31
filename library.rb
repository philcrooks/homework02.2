class Library
  # This class defines the library of karaoke files. Search results are also libraries.

  require_relative ('./song')

  LIBRARY_LOCATION = './library'
  
  attr_reader :songs  # only for test purposes

  def initialize(song_list = nil)
    @songs = []
    @songs = song_list if song_list # != nil
  end

  def add_song(artist, title, genre, filename = "filename.mp3")
    @songs << Song.new(artist, title, genre, LIBRARY_LOCATION + "/" + filename)
  end

  def song_search(search_field, search_value)
    return @songs.select { |s| s.send(search_field).downcase.include? (search_value.downcase) }
  end

end

