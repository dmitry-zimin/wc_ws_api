require 'mongoid'

# I've choose MongoDB as it's well known document db which is good for kinda storage that we need in this challenge
# And again, it depends on how we will scale this API, we can add some memory cache layer
# Or even store our key value data in MemCashe storage like Redis,
# As we have here simple data structure, hash table, ex. { word: occurrence_count }
# And if we will consider this API only for english words,
# it is not a big number of entries, 466k english words based on https://github.com/dwyl/english-words

class WordStatisticModel
  include Mongoid::Document

  field :word
  field :count, type: Integer, default: 0

  validates :word, presence: true, uniqueness: { message: 'Record already exists.' }
  validates :count, presence: true

  index({ word: 1, count: 1 }, unique: true, background: true)
end
