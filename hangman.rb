class Hangman
	attr_accessor :word, :guess, :attempts, :used

	#pick a word for the solution
	def initialize
		@word = get_words.sample
		@guess = @word.gsub(/./, '_')
		@attempts = 6
		@used = []
	end

	def play
		until is_over?
			puts @guess
			puts "#{attempts} attempts left"
			puts "Used #{@used}"

			letter = get_letter

			replace_letter(letter) if is_letter_there?(letter)

			@used << letter
		end

		puts "The correct solution is #{@word}"

		if has_won?
			puts "Congratulations, you win!"
		else
			puts "Sorry, you lose"
		end
	end

	def get_letter
		puts "Pick a letter"
		letter = gets.chomp.downcase

		if @used.include?(letter)
			puts "Sorry, that letter has already been used"
			get_letter
		elsif /\w/.match(letter)
			letter[0]
		else
			puts "Sorry, your input is invalid"
			get_letter
		end
	end

	def is_letter_there?(letter)
		if @word.include?(letter)
			puts "The word contains #{letter}"
			true
		else
			@attempts -= 1
			puts "The word does not contain #{letter}"
			false
		end
	end

	def replace_letter(letter)
		@word.split('').each_with_index do |x, i|
			@guess[i] = letter if letter == x
		end
	end

	def is_over?
		has_won? || has_lost?
	end

	def has_won?
		@guess == @word
	end

	def has_lost?
		@attempts == 0
	end
end

def get_words
	fname = "5desk.txt"
	words = File.open(fname).readlines
	words = format_words(words)

	between_5_and_12(words)
end

def format_words(words)
	words.map{|word| word.strip.downcase}
end

def between_5_and_12(words)
	words.select{|word| word.length >= 5 && word.length <= 12}
end

Hangman.new.play
