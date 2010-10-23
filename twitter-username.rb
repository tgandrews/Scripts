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

puts 'Verbose: ' + options[:verbose].to_s if options[:verbose ]

while !found
  if options[:verbose]
    puts ''
    puts 'Index: ' + i.to_s
    #puts 'No of letters ' + no_of_letters.to_s
  end
	twitter_name = ''

	while (length ** no_of_letters) <=  i
	  puts 'No of letters ' + no_of_letters.to_s if options[:verbose]
		no_of_letters = no_of_letters + 1
	end
	# The number of letters is one less than the max, 
	# if we want to convert the number 7 to base 2 we need 2^(x - 1) 'bits', the 3rd 'bit' will hold 8 on it's own 
	no_of_letters = no_of_letters - 1 if no_of_letters > 0

	carry = i
	twitter_name = ''
	l = no_of_letters
	while l >= 0
	  puts '----- loop: ' + l.to_s + ' -----' if options[:verbose]
	  max = length ** l
	  letter_idx = carry / max
	  # All loops apart from first will be treating letter array as 1 based, so let's fix that
	  letter_idx = letter_idx - 1 if (l > 0)
	  current_letter = letters[letter_idx]
	  carry = i % max
	  
	  if options[:verbose]
	    puts 'carry ' + carry.to_s
	    puts 'current_letter_idx ' + letter_idx.to_s
	    puts 'no_of_letters_tmp ' + l.to_s
	    puts 'current_letter ' + current_letter
    end
    twitter_name += current_letter
    
    l = l - 1
	end
	  
  # Try to retrieve information from twitter
	begin
		puts i.to_s + ': ' + twitter_name
		open('http://twitter.com/' + twitter_name)
	rescue
		break if twitter_name != 'i'
	else
	end
	
	break if !options[:stop].nil? and i >= options[:stop]
	i = i + 1
end

puts 'Found: ' + twitter_name
