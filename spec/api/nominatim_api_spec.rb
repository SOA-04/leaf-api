# frozen_string_literal: true

require_relative '../spec_helper'

require_relative '../../lib/services/nominatim_api'
require_relative '../../lib/services/api_errors'

describe 'Test Nominatim API library' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock
  end

  before do
    VCR.insert_cassette 'nominatim_api',
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end

  describe 'API Search Succeed' do
    it 'Receive correct data for NTHU search.' do
      correct_response = YAML.safe_load_file('spec/fixtures/nominatim_serach_nthu-results.yaml')
      nominatim_api = NominatimAPI.new
      payload = nominatim_api.search('清華大學')
      _(payload[0]['place_id']).must_equal correct_response[0]['place_id']
      _(payload[0]['name']).must_equal correct_response[0]['name']
      _(payload[0]['lat']).must_equal correct_response[0]['lat']
      _(payload[0]['lon']).must_equal correct_response[0]['lon']
      _(payload[1]['place_id']).must_equal correct_response[1]['place_id']
      _(payload[1]['name']).must_equal correct_response[1]['name']
      _(payload[1]['lat']).must_equal correct_response[1]['lat']
      _(payload[1]['lon']).must_equal correct_response[1]['lon']
    end
  end
end
