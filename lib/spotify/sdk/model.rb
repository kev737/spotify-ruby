# frozen_string_literal: true

module Spotify
  class SDK
    ##
    # For each SDK response object (i.e. Device), we have a Model class. We're using OpenStruct.
    #
    class Model < OpenStruct
      ##
      # Initialize a new Model instance.
      #
      # @param [Hash] hash The response payload.
      # @param [Spotify::SDK] parent The SDK object for context.
      #
      def initialize(payload, parent)
        @payload = payload
        validate_payload

        @parent = parent
        validate_parent

        super(payload)
      end

      ##
      # A reference to Spotify::SDK::Connect, so we can also do stuff.
      #
      attr_reader :parent

      private

      def validate_payload
        raise Spotify::Errors::ModelPayloadExpectedToBeHashError.new unless @payload.instance_of? Hash
      end

      def validate_parent
        raise Spotify::Errors::ModelParentInvalidSDKBaseObjectError.new unless @parent.is_a? Spotify::SDK::Base
      end
    end
  end

  class Errors
    ##
    # A Error class for when the payload is not a Hash instance.
    #
    class ModelPayloadExpectedToBeHashError < StandardError; end

    ##
    # A Error class for when the parent is not a Spotify::SDK::Base instance.
    #
    class ModelParentInvalidSDKBaseObjectError < StandardError; end
  end
end