require "words_counted"
require "mongoid"

require_relative "../lib/word_statistic_controller"
require_relative "../models/word_statistic_model"

def execute_rake_tasks
  `rake db:purge[test]`
  `rake db:create_indexes[test]`
end

describe WordStatisticController do
  it "count word occurrences in stream" do
    execute_rake_tasks
    Mongoid.load!("config/mongoid.yml", :test)
    str = "What what be be/n what"
    stream = StringIO.new(str)
    WordStatisticController.count_words_occurrence(stream)
    record = WordStatisticModel.where(word: "what").first
    expect(record.count).to eq(3)
  end
end