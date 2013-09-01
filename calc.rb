require 'pry'
def message i
  arr = ["enter a number, use decimal if you want float", "enter command: +, -, *, /, =, exit"]
  puts arr[i]
end
response = ''
which = 0
while true
  calc = []
  exp = ''
  while response != '=' && response != 'exit'
    message which
    response = gets.chomp
    calc << response
    if which == 0
      which = 1
    else
      which = 0
    end
  end
  if response == 'exit'
    exit
  end
  calc.pop
  calc.each do |element|
    exp += element
  end
  puts eval exp
  response = ''
end 