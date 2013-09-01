#1. Use the "each" method of Array to iterate over [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], and print out each value.
puts '#1'
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] 
arr.each do |element|
  puts element
end
puts '#2'
#2. Same as above, but only print out values greater than 5.
arr.each do |element|
  puts element if element > 5
end
puts '#3'
#3. Now, using the same array from #2, use the "select" method to extract all odd numbers into a new array.
new_arr = arr.select do |element|
  element.odd?
end
puts new_arr
puts '#4'
#4. Append "11" to the end of the array. Prepend "0" to the beginning.
arr << 11
puts arr
puts
arr.unshift(0)
puts arr
puts '#5'
#5. Get rid of "11". And append a "3".
arr.pop
arr << 3
puts arr
puts '6'
#6. Get rid of duplicates without specifically removing any one value. 
arr.uniq!
puts arr
puts '#7'
#7. What's the major difference between an Array and a Hash?
puts 'arrays are ordered, indexable list. hashes are unordered and contain key: value pairs'
#8. Create a Hash using both Ruby 1.8 and 1.9 syntax.
h = {:a => 1, :b => 2, :c => 3, :d => 4}
puts "ruby 1.8 syntax: #{h}"
h = {a:1, b:2, c:3, d:4}
puts "ruby 1.9 syntax: #{h}"
#Suppose you have a h = {a:1, b:2, c:3, d:4}
#9. Get the value of key "b".
puts "h[:b] =>  #{h[:b]}"
#10. Add to this hash the key:value pair {e:5}
h[:e] = 5
puts "h = #{h}"
#13. Remove all key:value pairs whose value is less than 3.5
h.each do |k, v|
  h.delete(k) if v < 3.5
end
puts "h = #{h}"
#14. Can hash values be arrays? Can you have an array of hashes? (give examples)
puts "hash values can me arrays and you can have array of hashes, consider:"
h[:f] = arr
puts "#{h}"
h[:g] = [{e: 5, f: 6}, {g: 7, h:8}]
puts "#{h}"
#15. Look at several Rails/Ruby online API sources and say which one your like best and why.
puts "http://railsapi.com/ searchable, build custom docs, topic @: http://stackoverflow.com/questions/2915975/is-there-a-combined-ruby-rails-online-documentation"