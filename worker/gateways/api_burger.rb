# frozen_string_literal: true

require 'http'
require 'net/http'
require 'json'
require 'uri'

module THSRParking
  module THSR
    # Library for THSR API
    class Api
      def send(input)
        Request.new.post(input)
      end

      # Request
      class Request
        POST_URL = ENV['POST_URL']

        def post(input)
          uri = URI.parse(POST_URL)
          header = {'Content-Type' => 'application/json'}
          park_left = {'ParkingAvailabilities' => input}

          http = Net::HTTP.new(uri.host, uri.port)
          request = Net::HTTP::Post.new(uri.request_uri, header)
          request.body = park_left.to_json

          post_response = http.request(request)
          Response.new(post_response).tap do |response|
            raise(response.error) unless response.http_error?
          end
        end
      end
      # Response SimpleDelegator
      # class Response < SimpleDelegator
      #   include Errors
      #   HTTP_ERROR = {
      #     400 => Errors::BadRequest,
      #     401 => Errors::Unauthorized,
      #     404 => Errors::NotFound
      #   }.freeze

      #   def http_error?
      #     HTTP_ERROR.keys.include?(code) ? false : true
      #   end

      #   def error
      #     HTTP_ERROR[code]
      #   end
      # end

      # def call_api
      #   uri = URI(API_URL)
      #   response = Net::HTTP.get_response(uri)
      #   http_error?(response.code) ? JSON.parse(response.body) : raise(HTTP_ERROR[response.code])
      # end

      # def http_error?(status_code)
      #   HTTP_ERROR.keys.include?(status_code) ? false : true
      # end
    end
  end
end
