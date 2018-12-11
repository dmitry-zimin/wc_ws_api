require 'uri'
require 'json'
require_relative '../lib/input_validator'

def json_params(input)
  JSON.parse(input)
end

describe InputValidator do
  it 'should validate string and return true' do
    input = '{"text": "Hi! My name is (what?), my name is (who?), my name is Slim Shady"}'
    validator = InputValidator.new(json_params(input))
    expect(validator.valid?).to eq(true)
  end

  it 'should validate file_path and return true' do
    input = '{"file_path": "testfile.txt"}'
    validator = InputValidator.new(json_params(input))
    expect(validator.valid?).to eq(true)
  end

  it 'should validate url and return true' do
    input = '{"url": "https://raw.githubusercontent.com/dmitry-zimin/wc_ws_api/init_phase/files/url_testfile.txt"}'
    validator = InputValidator.new(json_params(input))
    expect(validator.valid?).to eq(true)
  end
end
