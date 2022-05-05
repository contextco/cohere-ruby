module Cohere
  class Client
    include HTTParty
    base_uri "https://api.cohere.ai"

    def initialize(access_token: nil, version: nil)
      @access_token = access_token
      @version = version || "2021-11-08"; # currently latest, update when we version better
    end

    def classify(model:, options:)
      serialize post(endpoint: "classify", model: model, body: DEFAULT_CLASSIFY_PARAMS.merge(options))
    end

    def embed(model:, options:)
      threads = []
      default_options = DEFAULT_EMBED_PARAMS.merge(options)
      return OpenStruct.new(code: 400, body: { embeddings: [], ids: [] }) if default_options[:texts].empty?

      default_options[:texts].each_slice(1) do |batch|
        threads << threded_post(model: model, endpoint: "embed", body: default_options.merge(texts: batch))
      end

      results = threads.each(&:join).map(&:value)
      serialize_embed_results(results)
    end

    def generate(model:, options:)
      serialize post(endpoint: "generate", model: model, body: DEFAULT_GENERATE_PARAMS.merge(options))
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

    def serialize_embed_results(results)
      result = { body: { embeddings: [], ids: [] }, code: nil }
      results.each do |res|
        response = JSON.parse(res.response.body)
        result[:body][:embeddings].concat(response["embeddings"])
        result[:body][:ids] << response["id"]
        result[:code] = res.code
      end

      to_hash result
    end

    def threded_post(endpoint:, model:, body:)
      Thread.new do
        post(endpoint: endpoint, model: model,
             body: body)
      end
    end

    def serialize(response)
      serialized_response = { body: {}, code: {} }
      serialized_response[:body] = JSON.parse(response.response.body)
      serialized_response[:code] = response.code
      to_hash serialized_response
    end

    def to_hash(hash)
      result = hash.each_with_object({}) do |(key, val), memo|
        memo[key] = val.is_a?(Hash) ? to_hash(val) : val
      end
      OpenStruct.new result
    end
  end
end
