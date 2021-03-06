require_relative ('./bar')
require_relative ('./drink')
require_relative ('./library')
require_relative ('./song')
require_relative ('./tab')

class Guest

  attr_accessor :has_arrived, :music_library, :favourite_music
  attr_reader :bar_tab, :name, :favourite_drink, :credit

  def initialize (name, credit, drink)
    @name = name
    @credit = credit
    @bar_tab = Tab.new(name, credit)
    @favourite_music = {
      Song::SONG_TITLE => [],
      Song::ARTIST => [],
      Song::GENRE => []
    }
    @favourite_drink = drink
  end

  def choose_song(library)
    songs = []
    way_to_choose = Song::CATEGORIES[rand(Song::CATEGORIES.count)]
    if @favourite_music[way_to_choose] == []
      songs = library.song_search(Song::GENRE, "pop")
    else
      songs = library.song_search(way_to_choose, @favourite_music[way_to_choose].shuffle[0])
    end
    return songs.shuffle[0]
  end

  # def tab_total
  #   return @tab.total()
  # end

  def choose_drink(bar)
    choice = nil
    menu = bar.drinks_menu(@favourite_drink[:type])
    if menu.length > 0
      choice = menu.find { |drink| drink.brand == @favourite_drink[:brand] }
    else
      menu = bar.get_menu()
    end
    choice = menu.shuffle[0] if !choice
    return choice
  end

  def can_afford_drink?(drink)
    return @credit >= @bar_tab.total + drink.price
  end

  def buy_drink(drink)
    @bar_tab.add(drink)
  end
end