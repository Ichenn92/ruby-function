def translate (n)
    arr = create_array(n)
    new_array = []
    arr.each do |word|
        if %w(a e i o u y).include? word
            word.push("ay")
        else #for consonant
            until %w(a e i o u y).include? word[0]
                if word[0] == "q"
                    word.push(word[0])
                    word.push(word[1])
                    word.shift
                    word.shift
                else
                    word.push(word[0])
                    word.shift
                end
            end
            word.push("ay")
        end
        new_array.push(word.join(""))
    end
    new_array.join(" ")
end

def create_array (n)
    arr = []
    words = n.split
    
    for i in 0..(words.length - 1)
        arr.push(words[i].split(""))
    end

    return arr
end

###Have to learn those Regex
# def translate phrase
#     phrase.split.map do |word|
  
#       # we are using "/x" to document this big fat regex
#       word =~ /^     # beginning of string
#       (
#         [^aeiouyq]*  # any number of consonants in a row
#         (qu)?        # or maybe a 'qu'
#       )
#       (.*)           # the rest of the string
#       $/x            # end of string
  
#       # $1, $2, etc. get filled with the parenthesized chunks
#       # from the most recent regular expression match
#       first_phoneme = $1
#       rest_of_word = $3
#       "#{rest_of_word}#{first_phoneme}ay"
#     end.join(" ")
#   end