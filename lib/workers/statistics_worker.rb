require_relative "../../lib/input_processor"

class StatisticsWorker
  PROCESSOR_CLASS = {
      "text" => InputProcessor::StringStream,
      "file_path" => InputProcessor::FileStream,
      "url" => InputProcessor::UrlStream
  }.freeze
  include Sidekiq::Worker

  # here is raw implementation example, we can add some functionality with Sidekiq::Stats
  def perform(input)
    input_data = input.values[0]
    input_source = input.keys[0]
    input_processor = PROCESSOR_CLASS[input_source]
    data_stream = input_processor.get_stream(input_data)
    WordStatisticController.count_words_occurrence(data_stream)
    puts "Boom! processing the data"
  end
end
