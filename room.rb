require_relative ('./library')
require_relative ('./bar')
require_relative ('./guest')

class Room

  attr_reader :occupants, :new_arrivals, :name, :singer

  def initialize (name, capacity, library, bar)
    @name = name
    @capacity = capacity
    @music_library = library
    @bar = bar
    # @occupants[] is a queue - the person at the start of the list sings (is assigned to @singer then goes to the back 
    @occupants = []
    @new_arrivals = []
    @singer = nil
  end

  def change_singer
    if (@occupants.count > 0)
      if @singer
        @occupants.delete(@singer)
        @occupants << @singer
      end
      @singer = @occupants.first
    end
    return @singer
  end

  # def singer
  #   return @occupants.first
  # end

  def at_capacity?
    return @occupants.count >= @capacity
  end

  def add_occupant (guest)
    @new_arrivals << guest
    @occupants << guest
  end

  def something_happens
    # everyone in the room buys a drink and someone starts singing
    puts "\nIn the '#{@name}' room..."
    if new_arrivals.count > 0
      puts "Some people have just arrived:"
      @new_arrivals.each { |arrival| puts "   #{arrival.name}" }
      @new_arrivals = []
    end
    for guest in @occupants
      drink = guest.choose_drink(@bar)
      puts "#{guest.name} can't get his/her favourite drink of #{guest.favourite_drink[:brand]} (#{guest.favourite_drink[:type]})" if drink.brand != guest.favourite_drink[:brand]
      if guest.can_afford_drink?(drink)
        guest.buy_drink(drink)
        puts "#{guest.name} has ordered a #{drink.brand}."
      else
        puts "#{guest.name} would like a #{drink.brand} but has run out of credit."
      end
    end
    if @occupants.count > 1
      # No-one will sing unless there is an audience of at least 1
      change_singer()
      song = @singer.choose_song(@music_library)
      puts "#{@singer.name} is going to sing '#{song.title}' by #{song.artist}."
    end
  end

end
