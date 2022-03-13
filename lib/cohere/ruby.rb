# frozen_string_literal: true

require "httparty"
require_relative "ruby/version"
require_relative "ruby/client"

module Cohere
  module Ruby
    class Error < StandardError; end
  end
end
