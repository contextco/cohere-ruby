module Ruby
  class Client
    include HTTParty
    base_uri "https://api.cohere.ai"

    def initialize(access_token: nil, version: nil)
      @access_token = access_token
      @version = version || "2021-11-08"; # currently latest, update when we version better
    end

    def classify(model:, options:)
      post(endpint: "classify", model: model, body: options)
    end

    def embed(model:, options:)
      threads = []
      options.texts.each_slice(5) do |batch|
        threads << Thread.new { post(endpoint: "embed", model: model, options: options.merge({ texts: batch })) }
      end
      threads.each { |t| t.join }
    end

    def generate(model:, options:)
      post(endpoint: "generate", model: model, body: options)
    end

    def choose_best(model:, options:)
      post(endpoint: "choose-best", model: model, body: options)
    end

    private

    def post(model:, endpoint:, body:)
      self.class.post(
        "#{model}/#{endpoint}",
        headers: {
          "Authorization": "Bearer #{@access_token}",
          "Content-Type": "application/json",
          "Cohere-Version": self.COHERE_VERSION,
          "Request-Source": "ruby-sdk"
        },
        body: body.to_json
      )
    end
  end
end
