# Cohere::Ruby

The official SDK for the [Cohere](https://cohere.ai/) API.

Harness the power of language understanding. Join the developers and businesses who are using Cohere to generate, categorize and organize text at a scale that was previously unimaginable.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add cohere

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install cohere

## Usage

```ruby
    client = Cohere::Client.new access_token: "<COHERE_ACCESS_TOKEN>"
```

### Embed

See full docs [here](https://docs.cohere.ai/embed-reference).

- **texts**: `array of strings` - *required*
- **truncate**: `Accepts "NONE", "LEFT" or "RIGHT`, default `NONE` - *optional*

```ruby
    client.embed(model: "medium",
                options: { texts: ["When are you open?", "When do you close?", "What are the hours?",
                                    "Are you open on weekends?", "Are you available on holidays?"] })
```

### Classify

See full docs [here](https://docs.cohere.ai/classify-reference).

- inputs: `array of strings` - *required*
- examples: `array of {label:{},text:{}}` - *required*
- outputIndicator: `string` - *optional*
- taskDescription: `string` - *optional*
  
```ruby
    client.classify(model: "medium",
                    options: { inputs: [ "This item was broken when it arrived", "This item broke after 3 weeks" ], 
                    examples: [ 
                        { text: "The order came 5 days early", label: "positive" },
                        { text: "The item exceeded my expectations", label: "positive" }
                    ]})
```

### Generate

See full docs [here](https://docs.cohere.ai/generate-reference).

- prompt: `string` - *required*
- temperature: `number`. Default `0.75` - *optional*
- p: `number`. Default `0.75` - *optional*
- k: `number`. Default `0` - *optional*
- frequency_penalty: `number`. Default `0` - *optional*
- presence_penalty: `number`. Default `0` - *optional*
- max_tokens: `number`. Default `50` - *optional*
- stop_sequences: `array of strings` - *optional*
- return_likelihoods: `GENERATION|ALL|NONE`. Default `NONE` - *optional*
- num_generations: `number`. Default `1` - *optional*


```ruby
    client.generate(model: "medium", options: { prompt: "What is your name?" })
```

## Response

You can read more about the responses from the endpoints in our official API [docs site](https://docs.cohere.ai/api-reference/).

A struct containing:

- code: `http status code of the request`
- body: `the body contains a hash with the response body or a message if something went wrong`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cohere-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/cohere-ruby/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Cohere::Ruby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/cohere-ruby/blob/master/CODE_OF_CONDUCT.md).
