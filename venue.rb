require_relative('./room')
require_relative('./guest')
require_relative('./library')
require_relative('./song')

class Venue
  def initialize
    # Initialise the music library
    @master = Library.new
    @master.add_song("ABBA", "Waterloo", "pop") 
    @master.add_song("ABBA", "Dancing Queen", "pop")
    @master.add_song("Queen", "Bohemian Rhapsody", "rock")
    @master.add_song("Ed Sheeran", "Talking Out Loud", "pop,rock")

    # @metal = Library.new(@library.song_search(Song::GENRE, "metal"))
    # @rock_and_pop = Library.new(@library.song_search(Song::GENRE, "rock") << @library.song_search(Song::GENRE, "pop"))

    # Initialise the rooms
    @bar = Bar.new()
    @bar.add_drink("whisky", "Glenlivet Founder's Reserve", 4.0)
    @bar.add_drink("whisky", "Glenlivet 18", 7.5)
    @bar.add_drink("whisky", "Macallan Gold", 4.0)
    @bar.add_drink("whisky", "Macallan 18", 15.0)
    @bar.add_drink("whisky", "Famous Grouse", 3.0)
    @bar.add_drink("beer", "Williams Joker IPA", 5.0)
    @bar.add_drink("beer", "Beck's", 4.0)
    @bar.add_drink("beer", "Corona Extra", 4.0)
    @bar.add_drink("gin", "Beefeater", 3.0)
    @bar.add_drink("gin", "Hendrick's", 3.5)
    @bar.add_drink("vodka", "Grey Goose", 4.0)
    @bar.add_drink("vodka", "Smirnoff", 3.0)

    @rooms = []
    @rooms << Room.new("Troubadour", 3, @master, @bar)
    @rooms << Room.new("Cavern", 3, @master, @bar)

    # Initialise the guests
    @guests = []
    guest = Guest.new("Reg Wailer", 20.0, { type: "vodka", brand: "Grey Goose" })
    guest.favourite_music[Song::GENRE] = []
    guest.favourite_music[Song::ARTIST] = []
    guest.favourite_music[Song::SONG_TITLE] = []
    @guests << guest

    guest = Guest.new("Craig Crooner", 20.0, { type: "whisky", brand: "Famous Grouse" })
    guest.favourite_music[Song::GENRE] = []
    guest.favourite_music[Song::ARTIST] = []
    guest.favourite_music[Song::SONG_TITLE] = []
    @guests << guest

    guest = Guest.new("Mad Myrtle", 10.0, { type: "gin", brand: "Gordon's" })
    guest.favourite_music[Song::GENRE] = []
    guest.favourite_music[Song::ARTIST] = []
    guest.favourite_music[Song::SONG_TITLE] = []
    @guests << guest

    guest = Guest.new("Vocal Victor", 5.0, { type: "beer", brand: "Guinness" })
    guest.favourite_music[Song::GENRE] = []
    guest.favourite_music[Song::ARTIST] = []
    guest.favourite_music[Song::SONG_TITLE] = []
    @guests << guest

    guest = Guest.new("Moshpit Molly", 15, { type: "gin", brand: "Beafeater's" })
    guest.favourite_music[Song::GENRE] = []
    guest.favourite_music[Song::ARTIST] = []
    guest.favourite_music[Song::SONG_TITLE] = []
    @guests << guest

    guest = Guest.new("Larry Lungs", 25.0, { type: "whisky", brand: "Macallan 18" })
    guest.favourite_music[Song::GENRE] = []
    guest.favourite_music[Song::ARTIST] = []
    guest.favourite_music[Song::SONG_TITLE] = []
    @guests << guest

    guest = Guest.new("Whispering Bob", 100, { type: "beer", brand: "Williams Joker IPA" })
    guest.favourite_music[Song::GENRE] = []
    guest.favourite_music[Song::ARTIST] = []
    guest.favourite_music[Song::SONG_TITLE] = []
    @guests << guest

    @at_capacity = false
  end

  def find_a_room
    for room in @rooms
      return room if !room.at_capacity?
    end
    return nil
  end

  def run
    they_party_on = true
    while they_party_on
      puts "Time passes..."
      c = 0
      while c < 2
        if !@at_capacity
          guest = @guests.pop
          room = find_a_room()
          if room
            room.add_occupant(guest)
          else
            puts "There is no more space in the venue!"
            puts "No more guests will be allowed entry."
            @at_capacity = true
            break
          end
        end
        c += 1
      end

      @rooms.each { |r| r.something_happens if r.occupants.count > 0 }

      puts "Is it time to send everyone home? (y/n)"
      they_party_on = gets.chomp.downcase != "y"
      puts
    end
    puts "It's time to go home but first it's time to pay the bill."
    for room in @rooms
      for guest in room.occupants
        guest.print_tab
      end
    end
  end
end

venue = Venue.new
venue.run