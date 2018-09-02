class InputValidator
  attr_reader :input_data
  attr_reader :input_source

  def initialize(input)
    @input_data = input.values[0]
    @input_source = input.keys[0]
  end

  def valid_string?
    !input_data.to_s.strip.empty?
  end

  def valid_file_path?
    File.exist?(format_file_path)
  end

  def valid_url?
    uri = URI.parse(input_data)
    uri.kind_of?(URI::HTTP) && uri.kind_of?(URI::HTTPS) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def valid?
    case input_source
    when "text" then valid_string?
    when "file_path" then valid_file_path?
    when "url" then valid_url?
    else return false
    end
  end

  private
  attr_reader :input_data, :input_source

  def format_file_path
    "./files/#{input_data}"
  end
end
