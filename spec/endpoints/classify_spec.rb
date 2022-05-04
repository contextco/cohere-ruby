RSpec.describe Cohere::Client do
  before(:each) do
    @client = Cohere::Client.new access_token: ENV["COHERE_ACCESS_TOKEN"]
  end

  describe "Classify endpoint" do
    it "fails when no inputs and examples are given" do
      response = @client.classify(model: "small", options: {})
      expect(response.code).to eq(400)
    end

    it "fails when inputs without examples are given" do
      response = @client.classify(model: "small",
                                  options: { inputs: [
                                    "This item was broken when it arrived", "This item broke after 3 weeks"
                                  ] })
      expect(response.code).to eq(400)
    end

    it "succeeds when inputs and examples are given" do
      response = @client.classify(model: "small",
                                  options: { inputs: [
                                    "This item was broken when it arrived", "This item broke after 3 weeks"
                                  ], examples: [{ text: "The order came 5 days early", label: "positive" }, { text: "The item exceeded my expectations", label: "positive" }, { text: "I ordered more for my friends", label: "positive" }, { text: "I would buy this again", label: "positive" }, { text: "I would recommend this to others", label: "positive" }, { text: "The package was damaged", label: "negative" }, { text: "The order is 5 days late", label: "negative" }, { text: "The order was incorrect", label: "negative" }, { text: "I want to return my item", label: "negative" }, { text: "The item\'s material feels low quality", label: "negative" }] })
      expect(response.code).to eq(200)
    end
  end
end
