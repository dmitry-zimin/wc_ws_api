require_relative "spec_helper"
require_relative "../word_count_app"

RSpec.describe WordCountApp  do

  it "should respond with welcome msg" do
    get "/"
    expect(last_response).to be_ok
    expect(last_response.body).to eq("Welcome to the Words Statistic!")
  end

  it "should return error due to wrong word request" do
    get "/api/v1/word_statistics/wrongword"
    expect(last_response.status).to eq(404)
    expect(last_response.body).to eq('{"message":"Requested word was not appeared so far"}')
  end

  it "should return 200 status when i do POST with text input" do
    post "/api/v1/word_counter", params = '{ "input_source": { "text": "Hi! My name is (what?), my name is (who?), my name is Slim Shady" } }'
    expect(last_response.status).to eq(200)
  end

  it "should return count for predefined word" do
    WordStatisticModel.find_or_create_by(word: "test")
    get "/api/v1/word_statistics/test"
    expect(last_response).to be_ok
    expect(last_response.body).to eq("0")
  end
end