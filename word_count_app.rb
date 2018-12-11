# wc-server.rb

require 'sinatra/base'
require 'sinatra/namespace'
require 'mongoid'
require 'sidekiq'
require 'words_counted'

require_relative 'models/word_statistic_model'
require_relative 'lib/input_validator'
require_relative 'lib/word_statistic_dispatcher'
require_relative 'lib/workers/statistics_worker'
require_relative 'lib/word_statistic_processor'

class WordCountApp < Sinatra::Base
  register Sinatra::Namespace

  set :root, File.dirname(__FILE__)

  # DB Setup
  Mongoid.load!('config/mongoid.yml', ENV['RACK_ENV'].to_sym)

  # Endpoints
  get '/' do
    'Welcome to the Words Statistic API!'
  end

  namespace '/api/v1' do
    before do
      content_type 'application/json'
    end

    helpers do
      def json_params(request_body)
        JSON.parse(request_body)
      rescue StandardError
        halt 400, { message: 'Invalid JSON' }.to_json
      end
    end

    get '/word_statistics/:word' do
      word_stat = WordStatisticModel.where(word: params[:word].downcase).first
      halt(404, { message: 'Requested word was not appeared so far' }.to_json) if word_stat.nil?
      word_stat[:count].to_json
    end

    post '/word_counter' do
      req = request
      # here will be good to implement logic to save input and some data from request for backup and possible use in future
      word_processor = WordStatisticDispatcher.new(json_params(req.body.read))
      halt(422, { message: 'Input source is not valid', input: word_processor.input }.to_json) unless word_processor.valid?
      word_processor.start_processing; status 200
    end
  end
end
