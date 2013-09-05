def deal(deck, player_or_dealer)
  player_or_dealer << deck.pop
end

def print(player_or_dealer)
  player_or_dealer.each do |card|
    puts "  #{card}"
  end

  puts "  total: #{total(player_or_dealer)}"
  puts
end

def total(player_or_dealer)
  arr = player_or_dealer.map {|x| x.split(' ').first}

  total = 0
  arr.each do |value|
    if value == 'ace'
      total += 11
    elsif value.to_i == 0
      total += 10
    else
      total += value.to_i
    end
  end

  arr.select{|x| x == 'ace'}.count.times do
  total -= 10 if total > 21
  end

  total
end

def dealer_action dealer
  total(dealer) < 17 ? '1' : '2'
end

def get_response message
  response = '0'
  prompt = "what would you like to do? "
  prompt += message == 'play?' ?  '1)play, 2)exit' : '1)hit, 2)stay'
    while response != '1' && response != '2'
      puts prompt
      response = gets.chomp
      puts 'invalid entry' if response != '1' && response != '2' 
    end
    response
end

suit = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king', 'ace']
card = ['hearts', 'diamonds', 'spades', 'clubs']
deck1 = suit.product(card).map {|x| x.join(' of ')}


puts 'hello, what is your name'
name = gets.chomp
puts "good day #{name}, let's play some blackjack!"
while true

  response = get_response 'play?'
  exit if response == '2'

  current_deck = deck1.shuffle

  player = []
  dealer = []

  active_player = 'player'
  other_player = 'dealer'

  2.times {
  deal(current_deck, player)
  deal(current_deck, dealer)
  }

  if total(player) == 21
    puts "Blackjack!!"
    puts total(dealer) == 21 ? "Push, dealer also had blackjack" : "You won #{name}"
    puts "your current hand:"
    print player
    puts "dealer's hand:"
    print dealer
    next
  end

  while true

    #deal(current_deck, (eval active_player))
    puts "your current hand:"
    print(player)
    if active_player == 'player'
      puts "dealer's showing:"
      print [dealer.first]
    else
      puts "dealers hand:"
      print(dealer)
    end

    # check to see if active_player has busted
    if (total((active_player == 'player') ? player : dealer)) > 21
      puts "#{active_player} busts" + ((active_player == 'player') ? ' dealer wins' : " you win #{name}!!")
      break
    end

    if active_player == 'player'
      response = get_response 'hit or stay?'
      if response == '1' # ("hit")
        deal(current_deck, player)
        next
      else # response == '2' ("stay")
        active_player = 'dealer'
        other_player = 'player'
        puts "dealer's hand:"
        print dealer
      end
    end

    if active_player == 'dealer'
      response = dealer_action dealer
      puts '=> dealer' + ((response == '1') ? ' hits' : ' stays')
      if response == '1'
        deal(current_deck, dealer)
        next
      elsif total(player) == total(dealer) 
        puts "push, game over"
      else
        puts total(player) > total(dealer) ? "you win #{name}!!" : "you lose, dealer has better hand"
      end
      break
    end
  end
end