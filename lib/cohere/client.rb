module Cohere
  class Client
    include HTTParty
    base_uri "https://api.cohere.ai"

    def initialize(access_token: nil, version: nil)
      @access_token = access_token
      @version = version || "2021-11-08"; # currently latest, update when we version better
    end

    def classify(model:, options:)
      post(endpoint: "classify", model: model, body: DEFAULT_CLASSIFY_PARAMS.merge(options))
    end

    def embed(model:, options:)
      threads = []
      default_options = DEFAULT_EMBED_PARAMS.merge(options)
      default_options[:texts].each_slice(1) do |batch|
        threads << Thread.new do
          post(endpoint: "embed", model: model,
               body: default_options.merge({ texts: batch }))
        end
      end
      result = { body: { embeddings: [], ids: [] }, code: 400 }
      threads.each(&:join).map(&:value).each do |res|
        response = JSON.parse(res.response.body)
        result[:body][:embeddings].concat(response["embeddings"])
        result[:body][:ids] << response["id"]
        result[:code] = res.code
      end
      OpenStruct.new result
    end

    def generate(model:, options:)
      post(endpoint: "generate", model: model, body: DEFAULT_GENERATE_PARAMS.merge(options))
    end

    private

    def post(model:, endpoint:, body:)
      self.class.post(
        "/#{model}/#{endpoint}",
        headers: {
          "Authorization": "Bearer #{@access_token}",
          "Content-Type": "application/json",
          "Cohere-Version": @version,
          "Request-Source": "ruby-sdk"
        },
        body: body.to_json
      )
    end

    def embed_in_threads; end
  end
end
