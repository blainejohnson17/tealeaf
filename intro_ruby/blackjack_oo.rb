class Deck
  def initialize(num)
    @deck = create_deck(num)
  end

  def deal player_or_dealer
    player_or_dealer.hand << @deck.pop
  end

  def create_deck(num)
    suit = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king', 'ace']
    card = ['hearts', 'diamonds', 'spades', 'clubs']
    deck = suit.product(card).map {|x| x.join(' of ')} * num
    deck.shuffle!
  end
end

class Participant
  attr_accessor :hand, :name

  def initialize(name)
    @name = name
    @hand = []
  end

  def to_s
    response = "#{name}'s hand:\n"
    @hand.each {|card| response += "  #{card}\n"}
    response += "  Total: #{total(@hand)}"
    response
  end

  def total(hand)
    jack, queen, king, ace = 10, 10, 10, 11
    arr = hand.map {|x| x.split(' ').first}
    total_value = arr.inject(0) do |total, element|
      total + (element.to_i == 0 ? eval(element) : element.to_i)
    end
    arr.select{|x| x == 'ace'}.count.times do
      total_value -= 10 if total_value > 21
    end
    total_value
  end
end

current_deck = Deck.new(1)
player = Participant.new("Blaine")
dealer = Participant.new("Dealer")

2.times do
  current_deck.deal(player)
  current_deck.deal(dealer)
end

puts player
puts dealer