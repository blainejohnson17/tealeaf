class Card
  attr_accessor :face, :suit

  def initialize(face, suit)
    @face = face
    @suit = suit
  end

  def to_s
    "#{@face.capitalize} of #{@suit.capitalize}"
  end

end

class Deck
  include Enumerable
  attr_accessor :deck
  def initialize(num)
    @deck = create_deck(num).shuffle!
  end

  def deal
    deck.pop
  end

  def each
    deck.each { |card| yield card}
  end

  def create_deck(num)
    arr = []
    face = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king', 'ace']
    suit = ['hearts', 'diamonds', 'spades', 'clubs']
    face.each { |f| suit.each { |s| arr << Card.new(f, s) } }
    arr
  end
end

module Hand
  include Enumerable

  def add_card(card)
    hand << card
  end

  def to_s
    response = "\n--- #{name.capitalize}'s Hand: ---\n"
    hand.each{|card| response += "  => #{card}\n"}
    response
  end

  def clear_hand
    hand.clear
  end

  def each
    hand.each { |card| yield card }
  end
end

class Player
  include Hand
  attr_reader :name
  attr_accessor :hand

  def initialize(name)
    @name = name
    @hand = []
  end
end

class Dealer
  include Hand
  attr_reader :name
  attr_accessor :hand

  def initialize
    @name = "Dealer"
    @hand = []
  end
end

class Blackjack
  attr_accessor :deck, :player, :dealer, :participants
  STAY_MIN = 17

  def initialize
    @deck = new_deck
    @dealer = Dealer.new
    @participants = []
  end

  def new_deck
    Deck.new(1)  
  end
  
  def get_name
    puts "Welcome, to Blackjack!"
    print "Please enter your name: "
    gets.chomp
  end

  def add_player
    participants << Player.new("#{get_name}")
  end

  def remove_player
    participants.each.with_index { |p, i| puts "Player#{i + 1}: #{p}"}
  end

  def total(hand)
    jack, queen, king, ace = 10, 10, 10, 11
    arr = hand.map { |card| card.face }
    total_value = arr.inject(0) do |total, element|
      total + (element.to_i == 0 ? eval(element) : element.to_i)
    end
    arr.select { |x| x == 'ace' }.count.times do
      total_value -= 10 if total_value > 21
    end
    total_value
  end

  def show_hand(player_or_dealer)
    puts player_or_dealer
    puts " >>>> Total: #{total(player_or_dealer)} <<<<"
  end

  def show_flop
    puts "\n--- #{dealer.name.capitalize}'s Hand: ---"
    puts "  => #{dealer.first}"
    puts "  => Second card hidden "
    puts " >>>> Total: #{total([dealer.first])} <<<<"
  end
  def deal
    2.times do
      participants.each { |player| player.add_card(deck.deal) }
      dealer.add_card(deck.deal)
      puts deck.count
    end 
  end

  def play_again
    participants.each { |participant| participant.clear_hand }
    dealer.clear_hand
    self.deck = new_deck
    start_game
  end

  def play
    while true
      response = get_response("1)play, 2)add player 3)remove player 4)exit : ", '1', '2', '3', '4')
      case response
      when '1' then return
      when '2' then add_player
      when '3' then remove_player
      else          exit
      end
    end
  end

  def blackjack?(player)
    total(player) == 21 ? true : false
  end

  def blackjack
    puts "\n-->> Blackjack!! <<--"
  end

  def bust?(player_or_dealer)
    total(player_or_dealer) > 21 ? true : false
  end

  def bust(player_or_dealer)
    show_hand(player_or_dealer)
    puts "\n-->> #{player_or_dealer.name.capitalize} Busted <<--"
  end

  def get_response(message, *options)
    prompt = "\nWhat would you like to do? "
    prompt += message
    while true
      print prompt
      response = gets.chomp
      options.include?(response) ? (return response) : (puts 'invalid entry')
    end
  end

  def players_turn(player)
    while (get_response "#{player.name.capitalize}'s turn, 1)hit or 2)stay :", '1', '2') == '1'
      player.add_card(deck.deal)
      puts "\n--> #{player.name.capitalize} HITS <--"
      if bust?(player)
        bust(player)
        return
      end
      show_hand(player)
    end
    puts "\n--> #{player.name.capitalize} STAYS <--"
  end

  def dealers_turn
    return if participants.select { |player| !bust?(player) }.count == 0
    return if participants.select { |player| total(player) == 21 && player.count == 2 }.count == participants.count
    while total(dealer) < STAY_MIN
      dealer.add_card(deck.deal)
      puts "\n--> Dealer HITS <--"
      if bust?(dealer)
        bust(dealer)
        return
      end
      show_hand(dealer)
    end
    puts "\n--> Dealer STAYS <--"
  end

  def who_won
    puts "\n--> Final Results <--"
    participants.each do |player|
      puts "\n--> #{player.name.capitalize}'s Final Hand <--"
      show_hand(player)
      case
      when total(player) > 21
        puts "\n--> #{player.name.capitalize} Busted <--"
      when total(player) == total(dealer)
        puts "\n--> PUSH <--"
      when total(player) < total(dealer) && total(dealer) <= 21
        puts "\n--> #{player.name.capitalize} Loses <--"
      else
        puts "\n--> #{player.name.capitalize} Wins <--"
      end
    end
    play_again
  end

  def start_game
    play
    deal
    show_flop
    participants.each do |player|
      show_hand(player)
      if blackjack?(player)
        blackjack
        next
      end
      players_turn(player)
    end
    show_hand(dealer)
    dealers_turn
    who_won
  end
end

game = Blackjack.new
game.start_game