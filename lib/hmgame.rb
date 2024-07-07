require_relative 'hmword.rb'

class HmGame

  def initialize
    @word = HmWord.new.chosen_word
    @guesses_left = 6
    @guessed_letters = []
    @correct_position = Array.new(@word.length, '_')
    @incorrect_letters = []
  end

  def the_word
    @word
  end

  def get_guess
    puts "Guess a letter: "
    guess = gets.chomp.downcase
    if @word.include?(guess)
      correct_guess(guess)
    else
      incorrect_guess(guess)
    end
  end

  def correct_guess(guess)
    @guessed_letters << guess
    @word.chars.each_with_index do |char, idx|
      if char == guess
        @correct_position[idx] = guess
      end
    end

    "Correct guess!!! The letter #{guess} is indeed in the word!!!"
  end

  def incorrect_guess(guess)
    @guessed_letters << guess
    @incorrect_letters << guess
    @guesses_left -= 1
    "incorrect guess!!! You have #{@guesses_left} guesses left!!!"
  end

  def display_word
    @correct_position.join(' ')
  end

  def win?
    !@correct_position.include?('_')
  end

  def play
    puts "Welcome to Hangman!"
    puts "The word: #{display_word}"
    loop do
      break if win? || @guesses_left <= 0
      puts get_guess
      puts "The word: #{display_word}"
    end

    if win?
      puts "Congratulations on your glorious VICTORYYY!!! You guessed the word: #{@word}"
    else
      puts "Game over! You have lost... The word was #{@word}. Better luck next time!"
    end
  end
end

newgame = HmGame.new
puts newgame.the_word
puts newgame.get_guess
puts newgame.play