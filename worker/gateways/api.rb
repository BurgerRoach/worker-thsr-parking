# frozen_string_literal: true

require 'http'

module THSRParking
  module THSR
    # Library for THSR API
    class Api
      def search
        Request.new.get
      end

      # Request
      class Request
        API_URL = 'https://traffic.transportdata.tw/MOTC/v1/Parking/OffStreet/ParkingAvailability/Rail/THSR?$format=JSON'

        def get
          http_response = HTTP.headers(
            'Content-Type'  => 'application/json',
            'Accept'        => 'application/json',
            'User-Agent'    => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36'
          ).get(API_URL)

          Response.new(http_response).tap do |response|
            raise(response.error) unless response.http_error?
          end
        end
      end
      # Response SimpleDelegator
      class Response < SimpleDelegator
        include Errors
        HTTP_ERROR = {
          400 => Errors::BadRequest,
          401 => Errors::Unauthorized,
          404 => Errors::NotFound
        }.freeze

        def http_error?
          HTTP_ERROR.keys.include?(code) ? false : true
        end

        def error
          HTTP_ERROR[code]
        end
      end

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
