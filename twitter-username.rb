require 'rubygems'
require 'hpricot'
require 'open-uri'

letters = Array.new
letters = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']

found = false
i = 0
# Zero based index
length = letters.length - 1


while !found
	poss_name = ''


	no_of_letters = 1
	while (length ** no_of_letters) < i
		no_of_letters = no_of_letters + 1
	end

	temp = i
	while no_of_letters >= 1
		if (temp < (length ** no_of_letters))
			current_letter += letters[temp % length]
		else
		end

		no_of_letters = no_of_letters - 1
	end

	begin
		puts 'Trying: ' + poss_name
		open('http://twiiter.com/' + poss_name)
	rescue
		break
	else
	end
	i = i + 1
end

puts 'Found: ' + poss_name
