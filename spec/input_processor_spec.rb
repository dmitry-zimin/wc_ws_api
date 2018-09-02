require_relative "../lib/input_processors/string_stream"
require_relative "../lib/input_processors/file_stream"
require_relative "../lib/input_processors/url_stream"

require "open-uri"

describe InputProcessor do
  it "should return StrinIO object when I pass string" do
    str = "What what be be/n what"
    stream = InputProcessor::StringStream.get_stream(str)
    expect(stream).to be_kind_of(StringIO)
  end

  it "should return StrinIO object when I pass file path" do
    file_path = "testfile.txt"
    stream = InputProcessor::FileStream.get_stream(file_path)
    expect(stream).to be_kind_of(StringIO)
  end

  it "should return StrinIO object when I pass url" do
    url = "https://raw.githubusercontent.com/dmitry-zimin/wc_ws_api/init_phase/files/url_testfile.txt"
    stream = InputProcessor::UrlStream.get_stream(url)
    expect(stream).to be_kind_of(StringIO)
  end
end
