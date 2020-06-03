def echo(action)
    action
end

def shout(action)
    action.upcase
end

def repeat(action, times = 2)
    ([action] * times).join(" ")
end

def start_of_word(word, length)
word.slice(0, length)
end

def first_word(sentence)
    sentence.split(" ").first
end

def titleize(s)
  words = s.split.map do |word|
    if %w(the and over).include?(word)
      word
    else
      word.capitalize
    end
  end
  words.first.capitalize!
  words.join(" ")
end