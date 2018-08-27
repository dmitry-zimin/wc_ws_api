# wc-server.rb

require "sinatra"
require "sinatra/namespace"
require "mongoid"

# DB Setup
Mongoid.load! "mongoid.config"

# Models
class WordCount
  include Mongoid::Document

  field :word, type: String
  field :count, type: Integer, default: 0

  validates :word, presence: true, uniqueness: {message: "Word already exists."}
  validates :count, presence: true

  index({ word: 1, count: 1 }, { unique: true, background: true })
end

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