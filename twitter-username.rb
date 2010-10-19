require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'optparse'
#include CommandLine

options = {}
optparse = OptionParser.new do |opts|
  options[:index] = 0
  opts.on( '-i', '--index index', 'Start index of search where 0 is a, 1 is b and so fourth') do |idx|
    options[:index] = idx.to_i
  end
  opts.on('-s', '--stop index', 'Index value to stop at') do |idx|
    options[:stop] = idx.to_i
  end
  options[:verbose] = false
  opts.on('-v', '--verbose', 'Enable verbose output') do 
    options[:verbose] = true
  end
end
optparse.parse!

i = options[:index]

letters = Array.new
letters = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']

found = false
# Zero based index
length = letters.length

break_point = 0
no_of_letters = 0

while !found
  if options[:verbose]
    puts ''
    puts 'Index: ' + i.to_s
    puts 'No of letters ' + no_of_letters.to_s
    puts 'Break point ' + break_point.to_s
  end
	twitter_name = ''

	if (i >= break_point)
	  while (length ** no_of_letters) <  i
	    puts 'No of letters ' + no_of_letters.to_s if options[:verbose]
		  no_of_letters = no_of_letters + 1
	  end
	  no_of_letters = no_of_letters - 1
	  break_point = i + (length ** no_of_letters)
  end

	carry = i
	twitter_name = ''
	no_of_letters_tmp = no_of_letters
	while no_of_letters_tmp >= 0
	  max = length ** no_of_letters_tmp
	  current_letter_idx = (carry / max)
	  current_letter_idx = (current_letter_idx - 1)
	  
	  puts 'carry = ' + carry.to_s + '%' + max.to_s if options[:verbose]
	  
	  carry = carry % max

    current_letter_idx = current_letter_idx - 1 if (carry == 0) and (no_of_letters_tmp > 0) 

	  current_letter = letters[current_letter_idx]
	  twitter_name += current_letter
	  no_of_letters_tmp = no_of_letters_tmp - 1
	  
	  if options[:verbose]
	    puts 'carry ' + carry.to_s
	    puts 'current_letter_idx ' + current_letter_idx.to_s
	    puts 'no_of_letters_tmp ' + no_of_letters_tmp.to_s
	    puts 'current_letter ' + current_letter
    end
	end
	  
  # Try to retrieve information from twitter
	begin
		puts i.to_s + ': ' + twitter_name
		#open('http://twitter.com/' + twitter_name)
	rescue
		break if twitter_name != 'i'
	else
	end
	
	break if i >= options[:stop]
	i = i + 1
end

puts 'Found: ' + twitter_name
