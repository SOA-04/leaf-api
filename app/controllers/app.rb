# frozen_string_literal: true

require 'roda'
require 'slim'

module LeafAPI
  # This is the main application class that handles routing in LeafAPI
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :assets, css: 'style.css', path: 'app/views/assets'
    plugin :common_logger, $stderr
    plugin :halt

    route do |routing|
      routing.assets
      response['Content-Type'] = 'text/html; charset=utf-8'
      setup_routes(routing)
    end

    private

    def setup_routes(routing)
      setup_root(routing)
      setup_location_routes(routing)
      setup_trip_routes(routing)
    end

    def setup_root(routing)
      routing.root do
        view 'home'
      end
    end

    def setup_location_routes(routing)
      routing.on 'locations' do
        setup_location_search(routing)
        setup_location_form(routing)
        setup_location_result(routing)
      end
    end

    def setup_location_search(routing)
      routing.post 'search' do
        handle_search(routing)
      end
    end

    def setup_location_form(routing)
      routing.is do
        routing.get do
          view 'location_form'
        end
      end
    end

    def setup_location_result(routing)
      routing.on String do |location_query|
        routing.get do
          handle_location_query(location_query)
        end
      end
    end

    def handle_search(routing)
      location_query = routing.params['location'].downcase
      routing.redirect "/locations/#{CGI.escape(location_query)}"
    end

    def handle_location_query(location_query)
      location_entity = LeafAPI::GoogleMaps::LocationMapper.new(
        LeafAPI::GoogleMaps::API,
        CONFIG['GOOGLE_TOKEN']
      ).find(location_query)

      view 'location_result', locals: { location: location_entity }
    end

    def setup_trip_routes(routing)
      routing.on 'trips' do
        setup_trip_submit(routing)
        setup_trip_form(routing)
        setup_trip_result(routing)
      end
    end

    def setup_trip_submit(routing)
      routing.post 'submit' do
        routing.redirect "#{routing.params['origin']}/#{routing.params['destination']}/#{routing.params['strategy']}"
      end
    end

    def setup_trip_form(routing)
      routing.is do
        routing.get do
          view 'trip_form'
        end
      end
    end

    def setup_trip_result(routing)
      routing.on String, String, String do |origin, destination, strategy|
        routing.get do
          origin ||= '24.795707, 120.996393'
          destination ||= '24.786930, 120.988428'
          strategy ||= 'walking'
          trip = trip_entities(origin, destination, strategy)

          view 'trip_result', locals: { trip: trip }
        end
      end
    end

    def handle_submit(routing)
      trip_params = extract_trip_data(routing)
      routing.redirect "#{trip_params[:origin]}/#{trip_params[:destination]}/#{trip_params[:strategy]}"
    end

    def extract_trip_data(routing)
      {
        origin: CGI.escape(routing.params['origin']),
        destination: CGI.escape(routing.params['destination']),
        strategy: CGI.escape(routing.params['strategy'])
      }
    end

    def trip_entities(origin, destination, strategy)
      mapper = LeafAPI::GoogleMaps::TripMapper.new(
        LeafAPI::GoogleMaps::API,
        CONFIG['GOOGLE_TOKEN']
      )

      mapper.find(CGI.unescape(origin), CGI.unescape(destination), CGI.unescape(strategy))
    end
  end
end
