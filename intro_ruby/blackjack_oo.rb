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
  def initialize(num)
    @deck = create_deck(num).shuffle!
  end

  def deal player_or_dealer
    player_or_dealer.hand << @deck.pop
  end

  def create_deck(num)
    deck = []
    face = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king', 'ace']
    suit = ['hearts', 'diamonds', 'spades', 'clubs']
    face.each { |f| suit.each { |s| deck << Card.new(f, s) } }
    deck
  end
end

class Participant
  include Comparable
  attr_accessor :hand, :name

  def initialize(name)
    @name = name
    @hand = []
  end

  def to_s
    response = "#{name.capitalize}'s hand:\n"
    @hand.each {|card| response += "  #{card}\n"}
    response += "  Total: #{total}"
    response
  end

  def total
    jack, queen, king, ace = 10, 10, 10, 11
    arr = @hand.map { |card| card.face }
    total_value = arr.inject(0) do |total, element|
      total + (element.to_i == 0 ? eval(element) : element.to_i)
    end
    arr.select{|x| x == 'ace'}.count.times do
      total_value -= 10 if total_value > 21
    end
    total_value
  end

  def <=>(other)
    self.total <=> other.total   
  end
end

current_deck = Deck.new(1)
player = Participant.new("blaine")
dealer = Participant.new("Dealer")

4.times do
  current_deck.deal(player)
  current_deck.deal(dealer)
end

puts player
puts dealer

puts (player > dealer ? "player's total is greater" : "dealer's total is greater")