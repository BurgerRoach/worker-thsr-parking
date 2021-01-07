# frozen_string_literal: true

require 'http'

require_relative '../infrastructure/gateways/api.rb'
temp = THSRParking::THSR::Api.new.search
puts temp
