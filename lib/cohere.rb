# frozen_string_literal: true

require "httparty"
require_relative "cohere/version"
require_relative "cohere/params"
require_relative "cohere/client"

module Cohere
  class Error < StandardError; end
end
