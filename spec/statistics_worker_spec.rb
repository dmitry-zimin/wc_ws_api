require 'words_counted'
require 'mongoid'
require 'sidekiq'

require_relative '../lib/../lib/workers/statistics_worker'
require_relative '../models/word_statistic_model'

def prepare_test_db
  `rake db:purge[test]`
  `rake db:create_indexes[test]`
  Mongoid.load!('config/mongoid.yml', :test)
end

describe StatisticsWorker do
  let(:str) { 'What what be be/n what' }
  let(:stream) { StringIO.new(str) }
  before { prepare_test_db }

  def process_words
    StatisticsWorker.new.process_stream(stream)
    WordStatisticModel.where(word: 'what').first
  end

  it 'count word occurrences in stream' do
    expect(process_words.count).to eq(3)
  end
end
