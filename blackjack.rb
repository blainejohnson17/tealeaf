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

def deal(deck, num)
  return_arr = []
  num.times do
    return_arr << deck.pop
  end
  return_arr
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

deck = shuffle deck
puts deck.to_s
player = []
dealer = []
player << deal(deck, 3)
puts player.to_s