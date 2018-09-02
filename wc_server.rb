# wc-server.rb
require "sinatra"
require "sinatra/namespace"
require "mongoid"

require_relative "models/word_statistic_model"
require_relative "lib/input_validator"



# Endpoints
get '/' do
  'Welcome to the Words Statistic!'
end

namespace '/api/v1' do

  before do
    content_type 'application/json'
  end

  get '/word_statistic/:word' do
    word_stat = WordCount.where(word: params[:word]).first
    halt(404, { message:'Requested word was not appeared so far'}.to_json) unless word_stat
    word_stat[:count].to_json
  end
end