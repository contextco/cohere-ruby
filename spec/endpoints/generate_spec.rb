RSpec.describe Cohere::Client do
  before(:each) do
    @client = Cohere::Client.new access_token: ENV["COHERE_ACCESS_TOKEN"]
  end

  describe "Generate endpoint" do
    it "fails when no prompt is given" do
      response = @client.generate(model: "small", options: {})
      expect(response.code).to eq(400)
    end

    it "succeeds when prompt is given" do
      response = @client.generate(model: "small", options: { prompt: "What is your name?" })
      expect(response.code).to eq(200)
    end
  end
end
