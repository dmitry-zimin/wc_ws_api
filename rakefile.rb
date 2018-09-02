require "mongoid"
require "rspec/core/rake_task"
require_relative "models/word_statistic_model"

def load_mongoid(env)
  Mongoid.load!("mongoid.yml", env)
end

namespace :db do
  task :create_indexes, :environment do |t, args|
    load_mongoid(args[:environment])
    WordStatisticModel.create_indexes
  end

  task :purge, :environment do |t, args|
    load_mongoid(args[:environment])
    Mongoid.purge!
  end
end

desc "Run all specs in spec directory"
RSpec::Core::RakeTask.new(:spec)
