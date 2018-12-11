require_relative '../lib/input_processors/string_stream'
require_relative '../lib/input_processors/file_stream'
require_relative '../lib/input_processors/url_stream'

require 'open-uri'

describe InputProcessor do
  let(:str) { 'What what be be/n what' }
  let(:string_stream) { InputProcessor::StringStream.get_stream(str) }
  let(:file_path) { 'testfile.txt' }
  let(:file_stream) { InputProcessor::FileStream.get_stream(file_path) }
  let(:url) { 'https://raw.githubusercontent.com/dmitry-zimin/wc_ws_api/master/files/url_testfile.txt' }
  let(:url_stream) { InputProcessor::UrlStream.get_stream(url) }

  it 'should return StrinIO object when I pass string' do
    expect(string_stream).to be_kind_of(StringIO)
  end

  it 'should return StrinIO object when I pass file path' do
    expect(file_stream).to be_kind_of(StringIO)
  end

  it 'should return StrinIO object when I pass url' do
    expect(url_stream).to be_kind_of(StringIO)
  end
end
