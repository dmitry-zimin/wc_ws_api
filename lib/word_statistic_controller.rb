class WordStatisticController
  class << self
    def count_words_occurrence(str_stream)
      # to speedup challenge execution I've picked up WordsCounted gem
      # token_frequency returns two-dimensional array where each element is a token and its frequency
      until str_stream.eof? do
        str = str_stream.gets
        words_counters = WordsCounted.count(str).token_frequency
        save_word_occurrence(words_counters)
      end
    ensure
      str_stream.close unless str_stream.closed?
    end

    def save_word_occurrence(words_count_array)
      words_count_array.each do |word_count|
        record = WordStatisticModel.find_or_create_by(word: word_count.first)
        record.count += word_count.last
        record.save!
      end
    end
  end
end