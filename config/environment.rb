# frozen_string_literal: true

require 'econfig'

module THSRParking
  # Setup config environment
  module THSR
    extend Econfig::Shortcut
    Econfig.env = ENV['WORKER_ENV'] || 'development'
    Econfig.root = File.expand_path('..', File.dirname(__FILE__))
    if Econfig.env == 'development'
      ENV['POST_URL'] = 'http://localhost:9090/api/v1/worker'
    else
      ENV['POST_URL'] = 'http://https://thsr-parking-api.herokuapp.com/api/v1/worker'
    end
  end
end
