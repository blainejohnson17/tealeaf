def shuffle arr
  return_arr = arr
  i = 0
  while i < return_arr.length
    rand_element = rand(arr.length)
    return_arr[i] = arr[rand_element]
    arr.delete(rand_element)
    i += 1
  end
  return_arr
end

def deal(deck, num, player)
  num.times do
    (eval player) << (eval deck).pop
  end
end

def print player
  total = 0
  player.each do |x|
      puts "#{x[0]}, value: #{x[1]}"
      total += x[1]
  end
  puts "total = #{total}"
end

def total player
  total = 0
  player.each do |x|
      total += x[1]
  end
  total
end

def dealer_action
  if (total dealer) < 17
    '1'
  else
    '2'
  end
end

# deck1 = {ace_of_hearts: 1, two_of_hearts: 2, three_of_hearts: 3, four_of_hearts: 4, five_of_hearts: 5, 
#         six_of_hearts: 6, siven_of_hearts: 7, eight_of_hearts: 8, nine_of_hearts: 9, ten_of_hearts: 10,
#         jack_of_hearts: 10, queen_of_hearts: 10, king_of_hearts: 10,
#         ace_of_diamonds: 1, two_of_diamonds: 2, three_of_diamonds: 3, four_of_diamonds: 4, five_of_diamonds:5,
#         six_of_diamonds: 6, seven_of_diamonds: 7, eight_of_diamonds: 8, nine_of_diamonds: 9, ten_of_diamonds: 10,
#         jack_of_diamonds: 10, queen_of_diamonds: 10, king_of_diamonds: 10, 
#         ace_of_clubs: 1, two_of_clubs: 2, three_of_clubs: 3, four_of_clubs: 4, five_of_clubs: 5, 
#         six_of_clubs: 6, seven_of_clubs: 6, eight_of_clubs: 8, nine_of_clubs: 9, ten_of_clubs: 10,
#         jack_of_clubs: 10, queen_of_clubs: 10, king_of_clubs: 10,
#         ace_of_spades: 1, two_of_spades: 2, three_of_spades: 3, four_of_spades: 4, five_of_spades: 5, 
#         six_of_spades: 6, seven_of_spades: 6, eight_of_spades: 8, nine_of_spades: 9, ten_of_spades: 10,
#         jack_of_spades: 10, queen_of_spades: 10, king_of_spades: 10}

deck = [['ace of hearts', 1], ['two of hearts', 2], ['three of hearts', 3], ['four of hearts', 4], ['five of hearts', 5],
        ['six of hearts', 6], ['seven of hearts', 7], ['eight of hearts', 8], ['nine of hearts', 9], ['ten of hearts', 10],
        ['jack of hearts', 10], ['queen of hearts', 10], ['king of hearts', 10],
        ['ace of diamonds', 1], ['two of diamonds', 2], ['three of diamonds', 3], ['four of diamonds', 4], ['five of diamonds', 5],
        ['six of diamonds', 6], ['seven of diamonds', 7], ['eight of diamonds', 8], ['nine of diamonds', 9], ['ten of diamonds', 10],
        ['jack of diamonds', 11], ['queen of diamonds', 10], ['king of diamonds', 10],
        ['ace of clubs', 1], ['two of clubs', 2], ['three of clubs', 3], ['four of clubs', 4], ['five of clubs', 5],
        ['six of clubs', 6], ['seven of clubs', 7], ['eight of clubs', 8], ['nine of clubs', 9], ['ten of clubs', 10],
        ['jack of clubs', 10], ['queen of clubs', 10], ['king of clubs', 10],
        ['ace of spades', 1], ['two of spades', 2], ['three of spades', 3], ['four of spades', 4], ['five of spades', 5],
        ['six of spades', 6], ['seven of spades', 7], ['eight of spades', 8], ['nine of spades', 9], ['ten of spades', 10],
        ['jack of spades', 10], ['queen of spades', 10], ['king of spades', 10]]

puts 'hello, what is your name'
name = gets.chomp
puts "good day #{name}, let's play some blackjack!"
game = 'intialize'
while true
  if game == 'intialize'
    response = '0'
    while response != '1' && response != '2'
      puts "what would you like to do #{name}? 1)play, 2)exit"
      response = gets.chomp
      puts 'invalid entry' if response != '1' && response != '2' 
      exit if response == '2'
    end
    current_deck = shuffle deck 
    player = []
    dealer = []
    cards_to_deal = 2
    active_player = 'player'
    other_player = 'dealer'
    cards_to_deal.times {
    deal('current_deck', 1, 'player')
    deal('current_deck', 1, 'dealer')
    cards_to_deal = 1
    }
  else
    deal('current_deck', 1, '(eval active_player)')
  end
  puts "your current hand:"
  print player
  if game == 'intialize'
    puts "dealer's showing:"
    print [dealer.first]
  else
    puts "dealer's hand:"
    print dealer
  end
  if (total active_player) > 21
    puts "#{active_player} busts"
    game = 'intialize'
    next
  end
  if (total active_player) == 21
    print player
    print dealer
    if (total other_player) != 21
      puts "#{active_player} wins"
      game = 'intialize'
      next
    else
      puts "push"
      game = 'intialize'
      next
    end
  end
  if active_player == 'player'
    response = '0'
    while response != '1' && response != '2'
      puts "what would you like to do #{name}? 1)hit, 2)stay"
      response = gets.chomp
      puts 'invalid entry' if response != '1' && response != '2'
    end
    if response == 1 # ("hit")
      game = 'continue'
      next
    else # response == '2' ("stay")
      game = 'continue'
      active_player = 'dealer'
      other_player = 'player'
    end
  elsif active_player == 'dealer'
    print player
    print dealer
    if (total dealer) > (total player)
      puts "you lose"
      game = 'intialize'
      next
    else
      response = dealer_action
      puts "dealer response: #{response}"
      if response == '1'
        game = 'continue'
        next
      elsif (total player) == (total dealer)# dealer wants to "stay"
        puts "push, game over"
        game = 'intialize'
        next
      else
        puts "you win!"
        game = 'intialize'
        next
      end
    end
  end
end  