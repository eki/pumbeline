# encoding: UTF-8

class RandomNameGenerator
  attr_reader :window_size, :lookup

  def initialize( window_size=2 )
    @window_size = window_size
    @lookup = {}
  end

  def process_words( words )
    words.each do |word|
      letters = word.split( // ).unshift( *[nil]*window_size )
      letters.length.times do |i|
        (lookup[letters[i,window_size]] ||= []) << letters[i+window_size]
      end
    end
  end

  def name
    ws = window_size
    s = [nil] * ws
    n = lookup[s[-ws, ws]][rand( lookup[s[-ws,ws]].length )]

    while n
      s << n
      n = lookup[s[-ws, ws]][rand( lookup[s[-ws,ws]].length )]
    end

    s.join
  end
end

