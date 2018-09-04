require "words_counted"
require "mongoid"
require "sidekiq"


require_relative "../lib/../lib/workers/statistics_worker"
require_relative "../models/word_statistic_model"

def execute_rake_tasks
  `rake db:purge[test]`
  `rake db:create_indexes[test]`
end

# this test is works fine but it should be rewritten
describe StatisticsWorker do
  it "count word occurrences in stream" do
    execute_rake_tasks
    Mongoid.load!("config/mongoid.yml", :test)
    str = "What what be be/n what"
    stream = StringIO.new(str)
    StatisticsWorker.new.process_stream(stream)
    record = WordStatisticModel.where(word: "what").first
    expect(record.count).to eq(3)
  end
end
