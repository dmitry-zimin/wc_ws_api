require 'uri'
require 'json'
require_relative '../lib/input_validator'

def json_params(input)
  JSON.parse(input)
end

describe InputValidator do
  let(:text_input) { '{"text": "Hi! My name is (what?), my name is (who?), my name is Slim Shady"}' }
  let(:file_path) { '{"file_path": "testfile.txt"}' }
  let(:url) { '{"url": "https://raw.githubusercontent.com/dmitry-zimin/wc_ws_api/init_phase/files/url_testfile.txt"}' }

  def check_input(type)
    InputValidator.new(json_params(type))
  end

  it 'should validate string and return true' do
    expect(check_input(text_input).valid?).to eq(true)
  end

  it 'should validate file_path and return true' do
    expect(check_input(file_path).valid?).to eq(true)
  end

  it 'should validate url and return true' do
    expect(check_input(url).valid?).to eq(true)
  end
end
