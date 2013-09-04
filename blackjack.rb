def deal(deck, player_or_dealer)
  player_or_dealer << deck.pop
end

def print(player_or_dealer)
  puts "total: #{total(player_or_dealer)}"
  player_or_dealer.each { |x| puts "#{x[0]}, value: #{x[1]}"}
end

def total(player_or_dealer)
  change_ace = false
  begin
    total = 0
    aces_high = 0
    player_or_dealer.each do |x|
      if x[1] == 11
        if change_ace
          x[1] = 1
          change_ace = false
        else
          aces_high += 1
        end
      end
      total += x[1]
    end
    change_ace = (total > 21 && aces_high != 0) ? true : false
  end while change_ace
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

deck = [['ace of hearts', 11], ['two of hearts', 2], ['three of hearts', 3], ['four of hearts', 4], ['five of hearts', 5],
        ['six of hearts', 6], ['seven of hearts', 7], ['eight of hearts', 8], ['nine of hearts', 9], ['ten of hearts', 10],
        ['jack of hearts', 10], ['queen of hearts', 10], ['king of hearts', 10],
        ['ace of diamonds', 11], ['two of diamonds', 2], ['three of diamonds', 3], ['four of diamonds', 4], ['five of diamonds', 5],
        ['six of diamonds', 6], ['seven of diamonds', 7], ['eight of diamonds', 8], ['nine of diamonds', 9], ['ten of diamonds', 10],
        ['jack of diamonds', 10], ['queen of diamonds', 10], ['king of diamonds', 10],
        ['ace of clubs', 11], ['two of clubs', 2], ['three of clubs', 3], ['four of clubs', 4], ['five of clubs', 5],
        ['six of clubs', 6], ['seven of clubs', 7], ['eight of clubs', 8], ['nine of clubs', 9], ['ten of clubs', 10],
        ['jack of clubs', 10], ['queen of clubs', 10], ['king of clubs', 10],
        ['ace of spades', 11], ['two of spades', 2], ['three of spades', 3], ['four of spades', 4], ['five of spades', 5],
        ['six of spades', 6], ['seven of spades', 7], ['eight of spades', 8], ['nine of spades', 9], ['ten of spades', 10],
        ['jack of spades', 10], ['queen of spades', 10], ['king of spades', 10]]

puts 'hello, what is your name'
name = gets.chomp
puts "good day #{name}, let's play some blackjack!"
while true
  response = get_response 'play?'
  exit if response == '2'
  current_deck = Array.new(deck)
  current_deck.shuffle!
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
    puts total(player) == 21 ? "Push, dealer also had blackjack" : "You won #{name}"
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
      puts 'dealer' + ((response == '1') ? ' hits' : ' stays')
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