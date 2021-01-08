# frozen_string_literal: true

require_relative 'init'

park_left = THSRParking::THSR::Api.new.search

result = THSRParking::THSR::Api.new.send(park_left)

puts result
