require_relative 'hmword.rb'
require 'yaml'

class HmGame
  attr_reader :word, :guesses_left, :guessed_letters, :correct_positions, :incorrect_letters

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
    puts "Guess a letter, 'save' to save the game, or 'load' to load a saved game: "
    guess = gets.chomp.downcase

    case guess
    when 'save'
      save_game
      "Game saved."
    when 'load'
      load_game
      "Game loaded."
    else
      if guess.length == 1 && guess.match?(/[a-z]/)
        if @word.include?(guess)
          correct_guess(guess)
        else
          incorrect_guess(guess)
        end
      else
        "Invalid input. Please enter a single letter, 'save', or 'load'."
      end
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

  def save_game
    yaml = YAML.dump(self)
    File.open('saved_game.yml', 'w') { |file| file.write(yaml) }
  end

  def load_game
    YAML.load_file('saved_game.yml')
  end
end

newgame = HmGame.new
puts newgame.get_guess
puts newgame.play