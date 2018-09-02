class WordStatisticDispatcher
  attr_reader :input

  def initialize(params_json)
    @input = params_json["input_source"]
  end

  def start_processing
    StatisticsWorker.perform_async(input)
  end

  # validation of the input source
  def valid?
    InputValidator.new(input).valid?
  end
end
