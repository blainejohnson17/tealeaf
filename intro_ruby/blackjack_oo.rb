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
  attr_accessor :deck
  def initialize(num)
    @deck = create_deck(num).shuffle!
  end

  def deal
    @deck.pop
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
    hand.each { |e| yield e }
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

  def initialize
    @deck = new_deck
    @player = Player.new("#{get_name}")
    @dealer = Dealer.new
    @participants = [@player, @dealer]
  end

  def new_deck
    Deck.new(1)  
  end
  
  def get_name
    puts "Welcome, to Blackjack!"
    print "Please enter your name: "
    gets.chomp
  end

  def total(hand)
    jack, queen, king, ace = 10, 10, 10, 11
    arr = hand.map { |card| card.face }
    total_value = arr.inject(0) do |total, element|
      total + (element.to_i == 0 ? eval(element) : element.to_i)
    end
    arr.select{|x| x == 'ace'}.count.times do
      total_value -= 10 if total_value > 21
    end
    total_value
  end

  def show_hand(player_or_dealer)
    puts player_or_dealer
    puts " >>>> Total: #{total(player_or_dealer)} <<<<"
  end

  def show_flop
    puts "\n--- #{dealer.name.capitalize}'s Hand ---"
    puts "  => #{dealer.first}"
    puts "  => Second card hidden "
    puts " >>>> Total: #{total([dealer.first])} <<<<"
  end
  def deal
    2.times do
      participants.each { |player_or_dealer| player_or_dealer.add_card(deck.deal) }
    end 
  end

  def play_again
    player.clear_hand
    dealer.clear_hand
    deck = new_deck
    response = get_response("1)play, 2)exit :")
    response == '1' ? start_game : exit
  end

  def blackjack?
    total(player) == 21 ? true : false
  end

  def blackjack
    puts "\n-->> Blackjack!! <<--"
    show_hand(dealer)
    puts total(dealer) == 21 ? "\n-->> Push, dealer also has Blackjack <<--" : "\n-->> You won #{player.name}!! <<--"
    play_again
  end

  def bust?(player_or_dealer)
    if total(player_or_dealer) > 21
      show_hand(player_or_dealer)
      puts "\n-->> #{player_or_dealer.name.capitalize} Busted <<--"
      puts player_or_dealer.class == Dealer ? "\n-->> YOU WIN!! <<--" : "\n-->> You Lose.. <<--"
      play_again
    end
  end

  def get_response message
    response = '0'
    prompt = "\nWhat would you like to do? "
    prompt += message
    while response != '1' && response != '2'
      print prompt
      response = gets.chomp
      puts 'invalid entry' if response != '1' && response != '2' 
    end
    response
  end

  def players_turn
    response = get_response '1)hit or 2)stay :'
    if response == '1'
      player.add_card(deck.deal)
      bust?(player)
      show_hand(player)
      players_turn
    end
  end

  def dealer_hit?
    total(dealer) < 17
  end

  def dealers_turn
    if dealer_hit?
      dealer.add_card(deck.deal)
      puts "\n--> Dealer HITS <--"
      bust?(dealer)
      show_hand(dealer)
      dealers_turn
    else
      puts "\n--> Dealer STAYS <--"
    end
  end

  def who_won
    if total(player) == total(dealer)
      puts "\n-->> PUSH <<--"
    else
      puts total(player) > total(dealer) ? "\n-->> YOU WIN!! <<--" : "\n-->> You Lose, Dealer has better hand <<--"
    end
    play_again
  end

  def start_game
    deal
    show_hand(player)
    show_flop
    blackjack if blackjack?
    players_turn
    show_hand(dealer)
    dealers_turn
    who_won
  end
end

game = Blackjack.new
game.start_game