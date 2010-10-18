require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'optparse'
#include CommandLine

options = {}
optparse = OptionParser.new do |opts|
  options[:index] = 0
  opts.on( '-i', '--index idx', 'Start index of search where 0 is a, 1 is b and so fourth') do |idx|
    options[:index] = idx.to_i
  end
end
optparse.parse!

i = options[:index]

letters = Array.new
letters = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']

found = false
# Zero based index
length = letters.length - 1

break_point = 0
no_of_letters = 0

while !found
  puts 'Index: ' + i.to_s
  puts 'No of letters ' + no_of_letters.to_s
  puts 'Break point ' + break_point.to_s
	twitter_name = ''

	if (i >= break_point)
	  while (length ** no_of_letters) < i
		  no_of_letters = no_of_letters + 1
	  end
	  break_point = i + (length ** no_of_letters)
  end

	carry = i
	twitter_name = ''
	no_of_letters_tmp = no_of_letters
	while no_of_letters_tmp >= 0
	  max = length ** no_of_letters_tmp
	  current_letter_idx = carry % (max)
	  puts 'current_letter_idx ' + current_letter_idx.to_s
	  carry = carry % (max)
	  current_letter = letters[current_letter_idx]
	  twitter_name += current_letter
	  no_of_letters_tmp = no_of_letters_tmp - 1
	end

	begin
		puts 'Trying: ' + twitter_name
		open('http://twitter.com/' + twitter_name)
	rescue
		break if twitter_name != 'i'
	else
	end
	i = i + 1
end

puts 'Found: ' + twitter_name
