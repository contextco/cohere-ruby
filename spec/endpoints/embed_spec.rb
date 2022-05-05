RSpec.describe Cohere::Client do
  before(:each) do
    @client = Cohere::Client.new access_token: ENV["COHERE_ACCESS_TOKEN"]
  end

  describe "Embed endpoint" do
    it "fails when no texts are given" do
      response = @client.embed(model: "small", options: { texts: [] })
      expect(response.code).to eq(400)
    end

    it "succeeds when texts are given" do
      response = @client.embed(model: "small",
                               options: { texts: ["When are you open?", "When do you close?", "What are the hours?",
                                                  "Are you open on weekends?", "Are you available on holidays?"] })

      expect(response.code).to eq(200)
    end
  end
end
