module WordStatisticProcessor
  def process_stream(str_stream)
    # to prevent case when stream cuts word in the middle
    # last token in the current stream chunk is saved and then prepended to the next chunk
    last_token = ""
    until str_stream.eof? do
      chunk = str_stream.gets
      concatenated_chunk = last_token + chunk
      last_token = chunk.split(/[\s]+/).last || ""
      words_frequency = count_words_occurrence(concatenated_chunk)
      save_word_occurrence(words_frequency)
    end
  ensure
    str_stream.close unless str_stream.closed?
  end
  
  def save_word_occurrence(words_frequency)
    words_frequency.each do |word, count|
      record = WordStatisticModel.find_or_create_by(word: word)
      record.count += count
      record.save!
    end
  end

  def count_words_occurrence(words)
    words_array = words.scan(/[\p{Alpha}\-']+/).map(&:downcase).reject{ |token| blank_or_non_words(token) }
    words_array.reduce(Hash.new(0)) { |res,w| res[w] += 1; res }
  end

  def blank_or_non_words(token)
    token.nil? || token.empty?
  end
end