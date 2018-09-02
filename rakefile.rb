require "mongoid"
require_relative "models/word_statistic_model"

namespace :db do
  task :create_indexes do
    Mongoid.load!("mongoid.yml", :development)
    WordStatisticModel.create_indexes
  end
end
