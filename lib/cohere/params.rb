module Cohere
  DEFAULT_GENERATE_PARAMS = { temperature: 0.75, p: 0.75, k: 0, frequency_penalty: 0, presence_penalty: 0,
                              max_tokens: 50, stop_sequences: [], return_likelihoods: "NONE", prompt: nil, num_generations: 1 }.freeze

  DEFAULT_EMBED_PARAMS = { texts: [], truncate: "NONE" }.freeze

  DEFAULT_CLASSIFY_PARAMS = { inputs: [], examples: [], outputIndicator: "", taskDescription: "" }.freeze
end
