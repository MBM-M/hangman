class HmWord
  @@word = ''
  @@words = File.readlines('google-10000-english-no-swears.txt')

  def random_index
    rand(@@words.length)
  end

  def random_word
    @@words[random_index]
  end

  def chosen_word
    @@word = random_word
    while !(@@word.length > 5 && @@word.length < 12)
      @@word = random_word
    end
    @@word.chomp!
    @@word
  end

  def word_length
    chosen_word.length
  end

end
