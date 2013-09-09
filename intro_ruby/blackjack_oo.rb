#module total(player_or_dealer)
#  arr = player_or_dealer.map {|x| x.split(' ').first}#

#  total = 0
#  arr.each do |value|
#    if value == 'ace'
#      total += 11
#    elsif value.to_i == 0
#      total += 10
#    else
#      total += value.to_i
#    end
#  end#

#  arr.select{|x| x == 'ace'}.count.times do
#  total -= 10 if total > 21
#  end#

#  total
#end

class Deck
  attr_reader :deck
  def initialize(num)
    @deck = create_deck(num)
  end

  def to_s
    "#{@deck}"
  end

  def deal player_or_dealer
    player_or_dealer << @deck.pop
  end

  def create_deck(num)
    suit = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king', 'ace']
    card = ['hearts', 'diamonds', 'spades', 'clubs']
    deck = suit.product(card).map {|x| x.join(' of ')} * num
    deck.shuffle!
  end
end

current_deck = Deck.new(1)
puts current_deck